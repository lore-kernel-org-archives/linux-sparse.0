From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: __user with scalar data types
Date: Tue, 20 Jun 2017 09:12:23 +0200
Message-ID: <CAKMK7uFdH4VBftjyVCbXqcu76qMTSvkVFRDB3tJtX3N+SNm72w@mail.gmail.com>
References: <20170619161509.GA25997@jcrouse-lnx.qualcomm.com>
 <20170619163438.GE10672@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20170619163438.GE10672@ZenIV.linux.org.uk>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Al Viro <viro@zeniv.linux.org.uk>, "Clark, Rob" <robdclark@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-sparse@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>
List-Id: linux-sparse@vger.kernel.org

T24gTW9uLCBKdW4gMTksIDIwMTcgYXQgNjozNCBQTSwgQWwgVmlybyA8dmlyb0B6ZW5pdi5saW51
eC5vcmcudWs+IHdyb3RlOgo+IE9uIE1vbiwgSnVuIDE5LCAyMDE3IGF0IDEwOjE1OjA5QU0gLTA2
MDAsIEpvcmRhbiBDcm91c2Ugd3JvdGU6Cj4KPj4gV2hpY2ggcmFpc2VkIGEgYmlrZXNoZWQgZGVi
YXRlIG92ZXIgd2hldGhlciBpdCBpcyBhcHByb3ByaWF0ZSB0byBtYXJrIGEgc2NhbGFyCj4+IHR5
cGUgYXMgX191c2VyLiAgTXkgb3BpbmlvbiBpcyB0aGF0IGl0IGlzIGFwcHJvcHJpYXRlIGJlY2F1
c2UgX191c2VyIHNob3VsZCBtYXJrCj4+IHVzZXIgbWVtb3J5IHJlZ2FyZGxlc3Mgb2YgdGhlIGNv
bnRhaW5lci4KPgo+IFdoYXQgdGhlIGhlbGw/ICBfX3VzZXIgaXMgYSBxdWFsaWZpZXIgbGlrZSBj
b25zdCwgdm9sYXRpbGUsIGV0Yy4gIEl0J3MgYSBwcm9wZXJ0eQo+IG9mICpwb2ludGVyKiAqdHlw
ZSouICBOb3Qgc29tZSBuZWJ1bG91cyAibWFya3MgdXNlcmxhbmQgbWVtb3J5IiB0aGluZy4KPgo+
PiBJJ20gbG9va2luZyBmb3Igb3BpbmlvbnMgb3Igc2VtaS1hdXRob3JpdGF0aXZlIGVkaWN0cyB0
byBkZXRlcm1pbmUgaWYgd2Ugc2hvdWxkCj4+IGVpdGhlciBzdGFydCBjaGFuZ2luZyBvdXIgdWFw
aSBoZWFkZXJzIG9yIGdvIG9mZiBhbmQgdHJ5IHRvIGZpZ3VyZSBvdXQgaG93IHRvCj4+IG1ha2Ug
c3BhcnNlIHVuZGVyc3RhbmQgdGhpcyBwYXJ0aWN1bGFyIHVzYWdlLgo+Cj4gU3RvcCBjYXJnby1j
dWx0aW5nLCBwbGVhc2UuCgpZZXAgdGhhdCdzIGNhcmdvLWN1bHRlZCwgYnV0IGZyb20gYSBxdWlj
ayBncmVwIG9ubHkgbXNtIGFuZCBxeGwKaGVhZGVycyBkbyB0aGlzICh0aGUgb3RoZXIgX191c2Vy
IGFubm90YXRpb25zIGluIHVhcGkvZHJtIGFyZSBmb3IKcG9pbnRlcnMsIHdoZXJlIGl0J3MgY29y
cmVjdCkuIEFkZGluZyB0aG9zZSBtYWludGFpbmVycy4KCkFsc28sIGlmIHlvdSB1c2UgdTY0X3Rv
X3VzZXJfcHRyIGhlbHBlciBtYWNybyBzcGFyc2Ugc2hvdWxkIGhhdmUKY2F1Z2h0IHRoaXMgKGlm
IG5vdCB3ZSdkIG5lZWQgdG8gaW1wcm92ZSB0aGUgbWFjcm8pLgotRGFuaWVsCi0tIApEYW5pZWwg
VmV0dGVyClNvZnR3YXJlIEVuZ2luZWVyLCBJbnRlbCBDb3Jwb3JhdGlvbgorNDEgKDApIDc5IDM2
NSA1NyA0OCAtIGh0dHA6Ly9ibG9nLmZmd2xsLmNoCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2RyaS1kZXZlbAo=
