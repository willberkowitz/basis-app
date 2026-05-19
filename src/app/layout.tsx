import type { Metadata } from "next";
import "./globals.css";
import Link from "next/link";

export const metadata: Metadata = {
  title: "Basis — Sports Franchise Intelligence",
  description: "Research-grade franchise scorecards and analytics",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className="h-full">
      <body className="min-h-full flex flex-col">
        <nav className="border-b border-[#2d3048] bg-[#0f1117] sticky top-0 z-50">
          <div className="max-w-7xl mx-auto px-6 h-14 flex items-center justify-between">
            <Link href="/" className="text-white font-bold text-lg tracking-tight">
              <span className="text-[#007ac1]">Basis</span>
            </Link>
            <div className="flex gap-6">
              <Link
                href="/scorecard"
                className="text-sm text-slate-400 hover:text-white transition-colors"
              >
                Scorecard
              </Link>
              <Link
                href="/research"
                className="text-sm text-slate-400 hover:text-white transition-colors"
              >
                Research
              </Link>
            </div>
          </div>
        </nav>
        <main className="flex-1">{children}</main>
      </body>
    </html>
  );
}
