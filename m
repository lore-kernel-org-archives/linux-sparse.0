From: Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH v3 00/12] x86, kbuild: revert macrofying inline assembly
 code
Date: Tue, 18 Dec 2018 19:43:29 +0000
Message-ID: <C6D4A9B6-EED6-4DF7-8085-B1D3D221D25A@vmware.com>
References: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545062607-8599-1-git-send-email-yamada.masahiro@socionext.com>
Content-Language: en-US
Content-ID: <71ABF3FD62F14A44B735806BFEA43BC6@namprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Richard Biener <rguenther@suse.de>, Segher Boessenkool <segher@kernel.crashing.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Andrey Ryabinin <aryabinin@virtuozzo.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Alok Kataria <akataria@vmware.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Jann Horn <jannh@google.co>
List-Id: linux-sparse@vger.kernel.org

PiBPbiBEZWMgMTcsIDIwMTgsIGF0IDg6MDMgQU0sIE1hc2FoaXJvIFlhbWFkYSA8eWFtYWRhLm1h
c2FoaXJvQHNvY2lvbmV4dC5jb20+IHdyb3RlOg0KPiANCj4gVGhpcyBzZXJpZXMgcmV2ZXJ0cyB0
aGUgaW4ta2VybmVsIHdvcmthcm91bmRzIGZvciBpbmxpbmluZyBpc3N1ZXMuDQo+IA0KPiBUaGUg
Y29tbWl0IGRlc2NyaXB0aW9uIG9mIDc3YjBiZjU1YmM2NyBtZW50aW9uZWQNCj4gIldlIGFsc28g
aG9wZSB0aGF0IEdDQyB3aWxsIGV2ZW50dWFsbHkgZ2V0IGZpeGVkLC4uLiINCj4gDQo+IE5vdywg
R0NDIHByb3ZpZGVzIGEgc29sdXRpb24uDQo+IA0KPiBodHRwczovL25hMDEuc2FmZWxpbmtzLnBy
b3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmdjYy5nbnUub3JnJTJGb25s
aW5lZG9jcyUyRmdjYyUyRkV4dGVuZGVkLUFzbS5odG1sJmFtcDtkYXRhPTAyJTdDMDElN0NuYW1p
dCU0MHZtd2FyZS5jb20lN0NjNDNmNDMzZDhjNjI0NGRlMTVmMTA4ZDY2NDNhNDllNCU3Q2IzOTEz
OGNhM2NlZTRiNGFhNGQ2Y2Q4M2Q5ZGQ2MmYwJTdDMCU3QzAlN0M2MzY4MDY1OTg4OTk5NjI2Njkm
YW1wO3NkYXRhPTg4VUoyNVJvaUhpazl2VENKS1pWNiUyRjd4cHpDR3N2S2I5TEZnMWtmRVlMMCUz
RCZhbXA7cmVzZXJ2ZWQ9MA0KPiBleHBsYWlucyB0aGUgbmV3ICJhc20gaW5saW5lIiBzeW50YXgu
DQo+IA0KPiBUaGUgcGVyZm9ybWFuY2UgaXNzdWUgd2lsbCBiZSBldmVudHVhbGx5IHNvbHZlZC4N
Cj4gDQo+IFtBYm91dCBDb2RlIGNsZWFudXBzXQ0KPiANCj4gSSBrbm93IE5hZGFtIEFtaXQgaXMg
b3Bwb3NlZCB0byB0aGUgZnVsbCByZXZlcnQuDQoNCk15IG5hbWUgaXMgTmFkYXYuDQoNCj4gSGUg
YWxzbyBjbGFpbXMgaGlzIG1vdGl2YXRpb24gZm9yIG1hY3JvZnlpbmcgd2FzIG5vdCBvbmx5DQo+
IHBlcmZvcm1hbmNlLCBidXQgYWxzbyBjbGVhbnVwcy4NCg0KTWFzYWhpcm8sIEkgdW5kZXJzdGFu
ZCB5b3VyIGNvbmNlcm5zIGFuZCBjcml0aWNpc20sIGFuZCBpbmRlZWQgdmFyaW91cw0KYWx0ZXJu
YXRpdmUgc29sdXRpb25zIGV4aXN0LiBJIGRvIGhhdmUgbXkgcmVzZXJ2YXRpb25zIGFib3V0IHRo
ZSBvbmUgeW91DQpwcm9wb3NlLCBzaW5jZSBpdCBtYWtlcyBjb2RpbmcgbW9yZSBjb21wbGljYXRl
ZCB0byBzaW1wbGlmeSB0aGUgTWFrZSBzeXN0ZW0uDQpZZXQsIG1vcmUgaW1wb3J0YW50LCBzdGFy
dGluZyB0aGlzIGRpc2N1c3Npb24gc3VkZGVubHkgbm93IGFmdGVyIFJDNyBpcw0Kc3RyYW5nZS4g
QW55aG93LCBzaW5jZSBpdOKAmXMgb2J2aW91c2x5IG5vdCBteSBjYWxsLCBwbGVhc2UgZG9u4oCZ
dCBtYWtlIGl0DQpzb3VuZCBhcyBpZiBJIGFtIGEgc2lkZSBpbiB0aGUgZGVjaXNpb24uDQoNCg==
