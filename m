From: Nadav Amit <namit@vmware.com>
Subject: Re: PROPOSAL: Extend inline asm syntax with size spec
Date: Wed, 10 Oct 2018 16:31:41 +0000
Message-ID: <5ACDEDEA-0E42-45F2-BC80-B96EC2ABC01D@vmware.com>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181007091805.GA30687@zn.tnic> <20181007132228.GJ29268@gate.crashing.org>
 <alpine.LSU.2.21.1810071534220.7867@wotan.suse.de>
 <20181008073128.GL29268@gate.crashing.org>
 <alpine.LSU.2.20.1810081105350.16707@zhemvz.fhfr.qr>
 <20181009145330.GT29268@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181009145330.GT29268@gate.crashing.org>
Content-Language: en-US
Content-ID: <5A119F1B1E5059458EBD0D02CC174E28@namprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Segher Boessenkool <segher@kernel.crashing.org>, Richard Biener <rguenther@suse.de>
Cc: Michael Matz <matz@suse.de>, Borislav Petkov <bp@alien8.de>, "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>, Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Sam Ravnborg <sam@ravnborg.org>, Alok Kataria <akataria@vmware.com>, Christopher Li <sparse@chrisli.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, Jan Beulich <JBeulich@suse.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Juergen Gross <jgross@suse.com>, Kate Stewart <kstewart@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, "linux-sparse@vger.kernel.org" <linux-sparse@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Philippe Ombredanne <pombredanne@nexb.com>
List-Id: linux-sparse@vger.kernel.org

YXQgNzo1MyBBTSwgU2VnaGVyIEJvZXNzZW5rb29sIDxzZWdoZXJAa2VybmVsLmNyYXNoaW5nLm9y
Zz4gd3JvdGU6DQoNCj4gT24gTW9uLCBPY3QgMDgsIDIwMTggYXQgMTE6MDc6NDZBTSArMDIwMCwg
UmljaGFyZCBCaWVuZXIgd3JvdGU6DQo+PiBPbiBNb24sIDggT2N0IDIwMTgsIFNlZ2hlciBCb2Vz
c2Vua29vbCB3cm90ZToNCj4+PiBPbiBTdW4sIE9jdCAwNywgMjAxOCBhdCAwMzo1MzoyNlBNICsw
MDAwLCBNaWNoYWVsIE1hdHogd3JvdGU6DQo+Pj4+IE9uIFN1biwgNyBPY3QgMjAxOCwgU2VnaGVy
IEJvZXNzZW5rb29sIHdyb3RlOg0KPj4+Pj4gT24gU3VuLCBPY3QgMDcsIDIwMTggYXQgMTE6MTg6
MDZBTSArMDIwMCwgQm9yaXNsYXYgUGV0a292IHdyb3RlOg0KPj4+Pj4+IE5vdywgUmljaGFyZCBz
dWdnZXN0ZWQgZG9pbmcgc29tZXRoaW5nIGxpa2U6DQo+Pj4+Pj4gDQo+Pj4+Pj4gMSkgaW5saW5l
IGFzbSAoIi4uLiIpDQo+Pj4+PiANCj4+Pj4+IFdoYXQgd291bGQgdGhlIHNlbWFudGljcyBvZiB0
aGlzIGJlPw0KPj4+PiANCj4+Pj4gVGhlIHNpemUgb2YgdGhlIGlubGluZSBhc20gd291bGRuJ3Qg
YmUgY291bnRlZCB0b3dhcmRzIHRoZSBpbmxpbmVyIHNpemUgDQo+Pj4+IGxpbWl0cyAob3IgYmUg
Y291bnRlZCBhcyAiMSIpLg0KPj4+IA0KPj4+IFRoYXQgc291bmRzIGxpa2UgYSBnb29kIG9wdGlv
bi4NCj4+IA0KPj4gWWVzLCBJIGFsc28gbGlrZSBpdCBmb3Igc2ltcGxpY2l0eS4gIEl0IGFsc28g
YXZvaWRzIHRoZSByZXF1aXJlbWVudA0KPj4gb2YgdHJhbnNsYXRpbmcgdGhlIG51bWJlciAoaW4g
Ynl0ZXM/KSBnaXZlbiBieSB0aGUgdXNlciB0bw0KPj4gIm51bWJlciBvZiBHSU1QTEUgaW5zdHJ1
Y3Rpb25zIiBhcyBuZWVkZWQgYnkgdGhlIGlubGluZXIuDQo+IA0KPiBUaGlzIHBhdGNoIGltcGxl
bWVudHMgdGhpcywgZm9yIEMgb25seSBzbyBmYXIuICBBbmQgdGhlIHN5bnRheCBpcw0KPiAiYXNt
IGlubGluZSIsIHdoaWNoIGlzIG1vcmUgaW4gbGluZSB3aXRoIG90aGVyIHN5bnRheC4NCj4gDQo+
IEhvdyBkb2VzIHRoaXMgbG9vaz8NCg0KSXQgbG9va3MgZ29vZCB0byBtZSBpbiBnZW5lcmFsLiBJ
IGhhdmUgYSBjb3VwbGUgb2YgcmVzZXJ2YXRpb25zLCBidXQgSQ0Kc3VzcGVjdCB5b3Ugd2lsbCBu
b3Qgd2FudCB0byBhZGRyZXNzIHRoZW06DQoNCjEuIEl0IGlzIG5vdCBiYWNrd2FyZCBjb21wYXRp
YmxlLCByZXF1aXJpbmcgYSBDIG1hY3JvIHRvIHdyYXAgaXQsIGFzIHRoZSANCmtlcm5lbCBtaWdo
dCBiZSBidWlsdCB3aXRoIGRpZmZlcmVudCBjb21waWxlcnMuDQoNCjIuIEl0IGlzIHNwZWNpZmlj
IHRvIGFzbS4gSSBkbyBub3QgaGF2ZSBpbiBtaW5kIGFub3RoZXIgdXNlIGNhc2UgKGV4Y2x1ZGlu
Zw0KdGhlIF9fYnVpbHRpbl9jb25zdGFudF9wKSwgYnV0IGl0IHdvdWxkIGJlIG5pY2VyIElNSE8g
dG8gaGF2ZSBhIGJ1aWx0aW4NCnNheWluZyDigJxpZ25vcmUgdGhlIGNvc3Qgb2YgdGhpcyBzdGF0
ZW1lbnTigJ0gZm9yIHRoZSBtYXR0ZXIgb2Ygb3B0aW1pemF0aW9ucy4NCg0KUmVnYXJkcywNCk5h
ZGF2
