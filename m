From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC 3/4] barriers: convert a control to a data dependency
Date: Mon, 7 Jan 2019 10:46:10 +0100
Message-ID: <20190107094610.GA2861@worktop.programming.kicks-ass.net>
References: <20190102205715.14054-1-mst@redhat.com>
	<20190102205715.14054-4-mst@redhat.com>
	<86023cbe-d1ae-a0d6-7b75-26556f1a0c1f@redhat.com>
	<20190106231756-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20190106231756-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, linux-doc@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>, Will Deacon <will.deacon@arm.com>, virtualization@lists.linux-foundation.org, David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-sparse@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Matt Turner <mattst88@gmail.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Daniel Lustig <dlustig@nvidia.com>, Nicholas Piggin <npiggin@gmail.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Luc Maranget <luc.maranget@inria.fr>, Richard Henderson <rth@twiddle.net>, Jade Alglave <j.alglave@ucl.ac.uk>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
List-Id: linux-sparse@vger.kernel.org

T24gU3VuLCBKYW4gMDYsIDIwMTkgYXQgMTE6MjM6MDdQTSAtMDUwMCwgTWljaGFlbCBTLiBUc2ly
a2luIHdyb3RlOgo+IE9uIE1vbiwgSmFuIDA3LCAyMDE5IGF0IDExOjU4OjIzQU0gKzA4MDAsIEph
c29uIFdhbmcgd3JvdGU6Cj4gPiBPbiAyMDE5LzEvMyDkuIrljYg0OjU3LCBNaWNoYWVsIFMuIFRz
aXJraW4gd3JvdGU6Cgo+ID4gPiArI2lmIGRlZmluZWQoQ09NUElMRVJfSEFTX09QVElNSVpFUl9I
SURFX1ZBUikgJiYgXAo+ID4gPiArCSFkZWZpbmVkKEFSQ0hfTkVFRFNfUkVBRF9CQVJSSUVSX0RF
UEVORFMpCj4gPiA+ICsKPiA+ID4gKyNkZWZpbmUgZGVwZW5kZW50X3B0cl9tYihwdHIsIHZhbCkg
KHsJCQkJCVwKPiA+ID4gKwlsb25nIGRlcGVuZGVudF9wdHJfbWJfdmFsID0gKGxvbmcpKHZhbCk7
CQkJXAo+ID4gPiArCWxvbmcgZGVwZW5kZW50X3B0cl9tYl9wdHIgPSAobG9uZykocHRyKSAtIGRl
cGVuZGVudF9wdHJfbWJfdmFsOwlcCj4gPiA+ICsJCQkJCQkJCQlcCj4gPiA+ICsJQlVJTERfQlVH
X09OKHNpemVvZih2YWwpID4gc2l6ZW9mKGxvbmcpKTsJCQlcCj4gPiA+ICsJT1BUSU1JWkVSX0hJ
REVfVkFSKGRlcGVuZGVudF9wdHJfbWJfdmFsKTsJCQlcCj4gPiA+ICsJKHR5cGVvZihwdHIpKShk
ZXBlbmRlbnRfcHRyX21iX3B0ciArIGRlcGVuZGVudF9wdHJfbWJfdmFsKTsJXAo+ID4gPiArfSkK
PiA+ID4gKwo+ID4gPiArI2Vsc2UKPiA+ID4gKwo+ID4gPiArI2RlZmluZSBkZXBlbmRlbnRfcHRy
X21iKHB0ciwgdmFsKSAoeyBtYigpOyAocHRyKTsgfSkKPiA+IAo+ID4gCj4gPiBTbyBmb3IgdGhl
IGV4YW1wbGUgb2YgcGF0Y2ggNCwgd2UnZCBiZXR0ZXIgZmFsbCBiYWNrIHRvIHJtYigpIG9yIG5l
ZWQgYQo+ID4gZGVwZW5kZW50X3B0cl9ybWIoKT8KPiA+IAo+ID4gVGhhbmtzCj4gCj4gWW91IG1l
YW4gZm9yIHN0cm9uZ2x5IG9yZGVyZWQgYXJjaGl0ZWN0dXJlcyBsaWtlIEludGVsPwo+IFllcywg
bWF5YmUgaXQgbWFrZXMgc2Vuc2UgdG8gaGF2ZSBkZXBlbmRlbnRfcHRyX3NtcF9ybWIsCj4gZGVw
ZW5kZW50X3B0cl9kbWFfcm1iIGFuZCBkZXBlbmRlbnRfcHRyX3ZpcnRfcm1iLgo+IAo+IG1iIHZh
cmlhbnQgaXMgdW51c2VkIHJpZ2h0IG5vdyBzbyBJJ2xsIHJlbW92ZSBpdC4KCkhvdyBhYm91dCBu
YW1pbmcgdGhlIHRoaW5nOiBkZXBlbmRlbnRfcHRyKCkgPyBUaGF0IGlzIHdpdGhvdXQgYW55IChy
KW1iCmltcGxpY2F0aW9ucyBhdCBhbGwuIFRoZSBhZGRyZXNzIGRlcGVuZGVuY3kgaXMgc3RyaWN0
bHkgd2Vha2VyIHRoYW4gYW4Kcm1iIGluIHRoYXQgaXQgd2lsbCBvbmx5IG9yZGVyIHRoZSB0d28g
bG9hZHMgaW4gcWVzdGlvbiBhbmQgbm90LCBsaWtlCnJtYiwgYW55IHByaW9yIHRvIGFueSBsYXRl
ciBsb2FkLgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
