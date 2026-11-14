import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "آنلاین مارکت جویبار من",
  description: "خرید میوه، تره‌بار، لبنیات و مواد غذایی در شهر جویبار",
};

export default function RootLayout({ children }: Readonly<{ children: React.ReactNode }>) {
  return <html lang="fa" dir="rtl"><body>{children}</body></html>;
}

"use client";

import { useMemo, useState } from "react";

type Product = { id: number; name: string; category: string; price: number; unit: string; emoji: string };
const products: Product[] = [
  { id: 1, name: "سیب قرمز", category: "میوه و سبزی", price: 78000, unit: "هر کیلو", emoji: "🍎" },
  { id: 2, name: "پرتقال شمال", category: "میوه و سبزی", price: 65000, unit: "هر کیلو", emoji: "🍊" },
  { id: 3, name: "موز", category: "میوه و سبزی", price: 115000, unit: "هر کیلو", emoji: "🍌" },
  { id: 4, name: "خیار", category: "میوه و سبزی", price: 42000, unit: "هر کیلو", emoji: "🥒" },
  { id: 5, name: "گوجه‌فرنگی", category: "میوه و سبزی", price: 39000, unit: "هر کیلو", emoji: "🍅" },
  { id: 6, name: "سبزی خوردن", category: "میوه و سبزی", price: 25000, unit: "هر بسته", emoji: "🥬" },
  { id: 7, name: "شیر کم‌چرب", category: "لبنیات", price: 38000, unit: "هر بطری", emoji: "🥛" },
  { id: 8, name: "ماست", category: "لبنیات", price: 52000, unit: "هر بسته", emoji: "🥣" },
  { id: 9, name: "پنیر", category: "لبنیات", price: 69000, unit: "هر بسته", emoji: "🧀" },
  { id: 10, name: "تخم‌مرغ", category: "لبنیات", price: 99000, unit: "هر شانه", emoji: "🥚" },
  { id: 11, name: "برنج ایرانی", category: "مواد غذایی", price: 185000, unit: "هر کیلو", emoji: "🍚" },
  { id: 12, name: "روغن مایع", category: "مواد غذایی", price: 89000, unit: "هر بطری", emoji: "🫒" },
  { id: 13, name: "عدس", category: "مواد غذایی", price: 95000, unit: "هر کیلو", emoji: "🫘" },
  { id: 14, name: "ماکارونی", category: "مواد غذایی", price: 32000, unit: "هر بسته", emoji: "🍝" },
];
const money = (n: number) => new Intl.NumberFormat("fa-IR").format(n) + " تومان";

export default function Home() {
  const [cart, setCart] = useState<Record<number, number>>({});
  const [category, setCategory] = useState("همه محصولات");
  const [showCart, setShowCart] = useState(false);
  const [notice, setNotice] = useState("");
  const categories = ["همه محصولات", "میوه و سبزی", "لبنیات", "مواد غذایی"];
  const visible = useMemo(() => category === "همه محصولات" ? products : products.filter(p => p.category === category), [category]);
  const count = Object.values(cart).reduce((a, b) => a + b, 0);
  const subtotal = products.reduce((sum, p) => sum + p.price * (cart[p.id] || 0), 0);
  const change = (id: number, amount: number) => setCart(old => ({ ...old, [id]: Math.max(0, (old[id] || 0) + amount) }));

  return (
    <main className="shell">
      <header className="topbar">
        <div className="brandmark">ج</div>
        <div><p className="eyebrow">خرید روزانه، آسان و مطمئن</p><h1>آنلاین مارکت <span>جویبار من</span></h1></div>
        <button className="cart" onClick={() => setShowCart(true)}>سبد خرید <b>{count.toLocaleString("fa-IR")}</b></button>
      </header>
      <section className="hero">
        <div className="hero-copy"><span className="tag">ویژه شهر جویبار</span><h2>تازگی را<br/><em>به خانه بیاورید</em></h2><p>میوه، تره‌بار، لبنیات و مایحتاج روزانه؛ ساده و سریع انتخاب کنید.</p><a className="cta" href="#products">مشاهده محصولات</a></div>
        <div className="hero-art" aria-hidden="true"><span>تازه</span><div className="fruit fruit-one">🍊</div><div className="fruit fruit-two">🍎</div><div className="fruit fruit-three">🥬</div></div>
      </section>
      <section className="delivery"><div><strong>ارسال در شهر جویبار</strong><small>فعلاً فقط محدوده شهر جویبار</small></div><div><strong>هزینه پیک: ۲۹٬۰۰۰ تومان</strong><small>به مبلغ سبد اضافه می‌شود</small></div><div><strong>پرداخت در محل</strong><small>پس از تأیید سفارش</small></div></section>
      <section id="products" className="products">
        <div className="section-heading"><div><p className="eyebrow">انتخاب روزانه شما</p><h2>محصولات فروشگاه</h2></div><span>قیمت‌ها نمونه و قابل ویرایش‌اند</span></div>
        <nav className="filters" aria-label="فیلتر دسته‌بندی">{categories.map(c => <button key={c} className={category === c ? "filter active" : "filter"} onClick={() => setCategory(c)}>{c}</button>)}</nav>
        <div className="product-grid">{visible.map(p => <article className="product-card" key={p.id}><div className="product-emoji">{p.emoji}</div><span className="product-category">{p.category}</span><h3>{p.name}</h3><p className="unit">{p.unit}</p><div className="product-bottom"><strong>{money(p.price)}</strong><button className="add" onClick={() => change(p.id, 1)} aria-label={`افزودن ${p.name} به سبد`}>+</button></div>{(cart[p.id] || 0) > 0 && <div className="quantity"><button onClick={() => change(p.id, -1)}>−</button><b>{(cart[p.id] || 0).toLocaleString("fa-IR")}</b><button onClick={() => change(p.id, 1)}>+</button></div>}</article>)}</div>
      </section>
      <footer><strong>آنلاین مارکت جویبار من</strong><span>برای سفارش واقعی، قیمت و موجودی باید تأیید و درگاه ثبت سفارش متصل شود.</span></footer>
      {showCart && <div className="overlay" onClick={() => setShowCart(false)}><section className="cart-panel" onClick={e => e.stopPropagation()}><div className="cart-title"><h2>سبد خرید شما</h2><button className="close" onClick={() => setShowCart(false)}>×</button></div>{count === 0 ? <p className="empty">سبد خرید خالی است. از محصولات فروشگاه انتخاب کنید.</p> : <><div className="cart-lines">{products.filter(p => cart[p.id]).map(p => <div className="cart-line" key={p.id}><span>{p.emoji} {p.name}</span><div><button onClick={() => change(p.id, -1)}>−</button><b>{(cart[p.id] || 0).toLocaleString("fa-IR")}</b><button onClick={() => change(p.id, 1)}>+</button></div><strong>{money(p.price * cart[p.id])}</strong></div>)}</div><div className="totals"><p>جمع محصولات <b>{money(subtotal)}</b></p><p>هزینه ارسال <b>{money(29000)}</b></p><p className="grand">مبلغ قابل پرداخت <b>{money(subtotal + 29000)}</b></p></div><p className="demo-note">این نسخه فعلاً نمایشی است؛ سفارش و پرداخت هنوز به سرور متصل نیست.</p><button className="checkout" onClick={() => setNotice("سبد خرید آماده است؛ برای فعال شدن ثبت سفارش باید پایگاه داده و اطلاعات تماس فروشگاه متصل شود.")}>ادامه ثبت سفارش</button>{notice && <p className="notice">{notice}</p>}</>}</section></div>}
    </main>
  );
}

@import url('https://fonts.googleapis.com/css2?family=Vazirmatn:wght@400;500;600;700;800&display=swap');
:root{--bg:#0b0b0b;--panel:#151515;--gold:#d6b56d;--muted:#aaa398;--line:#302a1d}
*{box-sizing:border-box}html{scroll-behavior:smooth}body{margin:0;background:var(--bg);color:#f7f2e8;font-family:Vazirmatn, Tahoma, sans-serif}.shell{max-width:1160px;margin:auto;padding:28px 24px}.topbar{display:flex;align-items:center;gap:14px}.brandmark{width:48px;height:48px;border:1px solid var(--gold);border-radius:15px;display:grid;place-items:center;color:var(--gold);font-size:27px;font-weight:800}.eyebrow{color:var(--gold);font-size:12px;margin:0 0 4px}.topbar h1{font-size:18px;margin:0}.topbar h1 span{color:var(--gold)}.cart{margin-right:auto;border:1px solid var(--line);background:#171717;color:#fff;border-radius:999px;padding:10px 16px;font:inherit}.cart b{color:var(--gold);margin-right:8px}.hero{margin-top:34px;border:1px solid var(--line);border-radius:28px;background:radial-gradient(circle at 78% 45%,#342817 0,#17140f 34%,#111 70%);min-height:330px;padding:42px;display:flex;align-items:center;justify-content:space-between;overflow:hidden}.hero-copy{max-width:510px}.tag{display:inline-block;border:1px solid #66532e;color:var(--gold);border-radius:999px;padding:5px 13px;font-size:12px}.hero h2{font-size:clamp(36px,6vw,62px);line-height:1.35;margin:14px 0}.hero h2 em{font-style:normal;color:var(--gold)}.hero p{color:#c6c0b5;line-height:2}.cta{display:inline-block;margin-top:12px;background:var(--gold);color:#15110a;text-decoration:none;padding:11px 22px;border-radius:12px;font-weight:700}.hero-art{width:300px;height:240px;position:relative;display:grid;place-items:center;border:1px solid #4b3b20;border-radius:50%;background:radial-gradient(circle,#4b381b 0,#231b10 55%,transparent 70%)}.hero-art>span{position:absolute;top:20px;right:25px;color:var(--gold);font-size:13px}.fruit{position:absolute;font-size:72px;filter:drop-shadow(0 12px 10px #0008)}.fruit-one{top:48px;right:52px}.fruit-two{bottom:38px;left:48px}.fruit-three{top:90px;left:100px}.delivery{display:grid;grid-template-columns:repeat(3,1fr);gap:12px;margin:20px 0 52px}.delivery>div{background:var(--panel);border:1px solid var(--line);padding:17px;border-radius:16px}.delivery strong,.delivery small{display:block}.delivery strong{font-size:14px;color:var(--gold)}.delivery small{color:var(--muted);font-size:11px;margin-top:5px}.section-heading{display:flex;justify-content:space-between;align-items:end;margin-bottom:18px}.section-heading h2{margin:0;font-size:25px}.section-heading>span{font-size:11px;color:var(--muted)}.grid{display:grid;grid-template-columns:repeat(4,1fr);gap:14px}.category{background:var(--panel);border:1px solid var(--line);border-radius:18px;padding:20px}.category-icon{width:52px;height:52px;border-radius:16px;display:grid;place-items:center;font-size:27px;background:#282114}.category h3{margin:13px 0 8px;font-size:17px}.category ul{list-style:none;padding:0;margin:0}.category li{display:flex;justify-content:space-between;gap:8px;padding:9px 0;border-bottom:1px solid #29251f;font-size:13px}.category li:last-child{border:0}.category li span{color:#8f887c;font-size:10px;white-space:nowrap}footer{border-top:1px solid var(--line);margin-top:48px;padding:22px 0;display:flex;justify-content:space-between;gap:15px;color:var(--muted);font-size:11px}footer strong{color:var(--gold)}
@media(max-width:760px){.shell{padding:18px 14px}.hero{padding:26px;min-height:unset}.hero-art{width:150px;height:150px;flex-shrink:0}.fruit{font-size:42px}.fruit-one{top:30px;right:24px}.fruit-two{bottom:24px;left:22px}.fruit-three{top:55px;left:50px}.hero h2{font-size:36px}.delivery{grid-template-columns:1fr;gap:8px;margin-bottom:38px}.grid{grid-template-columns:repeat(2,1fr)}.category{padding:14px}.section-heading{align-items:start;gap:10px}.section-heading h2{font-size:20px}footer{flex-direction:column}}
@media(max-width:420px){.hero-art{display:none}.grid{grid-template-columns:1fr 1fr}.category li{font-size:12px}.category li span{font-size:9px}}
.filters{display:flex;gap:9px;flex-wrap:wrap;margin:18px 0}.filter{font:inherit;color:#d8d0c2;background:#171717;border:1px solid var(--line);border-radius:999px;padding:8px 16px;cursor:pointer}.filter.active{background:var(--gold);color:#17120a;border-color:var(--gold);font-weight:700}.product-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:14px}.product-card{position:relative;background:var(--panel);border:1px solid var(--line);border-radius:18px;padding:16px;min-width:0}.product-emoji{height:100px;border-radius:14px;background:radial-gradient(circle,#382b17,#201b13);display:grid;place-items:center;font-size:54px}.product-category{display:block;color:var(--gold);font-size:10px;margin-top:12px}.product-card h3{margin:4px 0;font-size:16px}.unit{margin:0;color:var(--muted);font-size:11px}.product-bottom{display:flex;align-items:center;justify-content:space-between;margin-top:14px;gap:6px}.product-bottom strong{font-size:12px;color:#f0d99f}.add,.quantity button,.cart-line button{border:0;background:var(--gold);color:#17120a;border-radius:9px;width:32px;height:32px;font-size:21px;cursor:pointer}.quantity{display:flex;align-items:center;justify-content:center;gap:14px;margin-top:10px}.quantity button,.cart-line button{width:25px;height:25px;font-size:17px}.overlay{position:fixed;inset:0;background:#000b;z-index:5;display:flex;justify-content:flex-start}.cart-panel{width:min(520px,100%);height:100%;overflow:auto;background:#131313;border-left:1px solid var(--line);padding:24px}.cart-title{display:flex;align-items:center;justify-content:space-between}.cart-title h2{font-size:21px}.close{background:none;border:0;color:#fff;font-size:30px;cursor:pointer}.empty,.demo-note,.notice{color:var(--muted);line-height:2;font-size:13px}.cart-lines{border-top:1px solid var(--line)}.cart-line{display:grid;grid-template-columns:1fr auto;gap:9px;padding:13px 0;border-bottom:1px solid var(--line);font-size:13px}.cart-line strong{grid-column:1/-1;color:var(--gold)}.cart-line div{display:flex;align-items:center;gap:10px}.totals{margin-top:20px}.totals p{display:flex;justify-content:space-between;color:#c7c0b4;font-size:13px}.totals .grand{border-top:1px solid var(--line);padding-top:14px;color:#fff;font-weight:700}.totals .grand b{color:var(--gold)}.checkout{width:100%;padding:13px;border:0;border-radius:12px;background:var(--gold);font:inherit;font-weight:700;cursor:pointer}.notice{background:#211d15;padding:10px;border-radius:10px}@media(max-width:760px){.product-grid{grid-template-columns:repeat(2,1fr)}}
