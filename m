From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Designated initializers for fields in anonymous structs and unions
Date: Sat, 2 Aug 2014 12:53:56 -0700
Message-ID: <CA+55aFzWAZ-ZQ6DSvnj6vQnwCHyDX11an1nOAo43UGaLcfshwg@mail.gmail.com>
References: <20140731181006.GA13180@cloud>
	<CA+55aFwinxO5H=5Rtgz37AuOCTHBDWJ6mVRU0HX+fiGP9JRa1Q@mail.gmail.com>
	<CA+55aFwhz6aHV145jLGJx9MH6Nb67TdHwE=Zz_0Vu4u6L8A7Dw@mail.gmail.com>
	<CA+55aFwfN1L6U=6+_a-Ue_Z6tPNfphKkpidtdD06zs+tHLPyJQ@mail.gmail.com>
	<CANeU7Qn4++T+GsL6pjnEem0SOWhGrvBN7TLC8p8Hjbw2xCmVbw@mail.gmail.com>
	<CA+55aFzfdfh80o1-BUA4CqurZ_A94cbNwCxHJZi-aFdLc+hF+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11339974bbe0b404ffaaddb1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:35771 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754808AbaHBTx5 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 2 Aug 2014 15:53:57 -0400
Received: by mail-vc0-f174.google.com with SMTP id la4so8740095vcb.5
        for <linux-sparse@vger.kernel.org>; Sat, 02 Aug 2014 12:53:56 -0700 (PDT)
In-Reply-To: <CA+55aFzfdfh80o1-BUA4CqurZ_A94cbNwCxHJZi-aFdLc+hF+w@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

--001a11339974bbe0b404ffaaddb1
Content-Type: text/plain; charset=UTF-8

On Sat, Aug 2, 2014 at 11:10 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>> Actually, the "find_identifier" call inside function "check_designators" already
>> calculate the correct offset. Only if we can pass that offset to
>> "convert_ident()".
>
> I actually tried that initially, and wanted to get rid of the whole
> "check_designators()" vs "convert_designators()", but couldn't really
> find a sane way to make that work. I'll look at it again, maybe I
> missed something.

No, I didn't miss anything.

The "trivial fix" is to just save off the offset in check_designators
(add a new field to the "EXPR_IDENTIFIER" part of "struct expression"
and then pick up that offset in "convert_ident()"

However, that has exactly the same issue with the whole fake
EXPR_IDENTIFIER created by "next_designators()". Now we need to
initialize the offset field there too. And, for the same reason as
before, the field that "next_designator()" picks may not *have* an
identifier, because the next designator may in fact be an anonymous
union.

Anyway, with all that said, maybe this really confusing and hacky
patch would work. It passes my tests. The magic offset calculation in
next_designators() has a big comment about what the heck it is doing,
and otherwise it's a fairly straightforward case of "save offset from
check_designators() time to be used by convert_ident()".

My stupid test-case is this incredibly hacky thing:

    struct A {
        int aa;
        int bb;
    };

    struct S {
        int a;
        union {
            int b;
            int c;
        } u[10];
        int dummy;
        union {
            int d;
            int e;
        };
    };

    int fn(void)
    {
        struct S s = {
            .a = 1,
            .u[2].b = 2,
            .dummy = 1,
             { 3 }
        };
        return s.dummy*1000 + s.d*100 + s.u[2].b*10 + s.a; // 1321
    }

where I use "./test-linearize" to verify that the initializer layout
matches the code generation layout (so that 'fn' function *should*
linearize to just a simple "ret.32 $1321", and with this patch it
does).

But I bet this misses some case. However, the current state wrt
initializer offsets really is very broken, so maybe it's ok.

Can anybody see anything wrong with it? It's reasonably simple. Every
place that initializes "expr->field" for an EXPR_IDENTIFIER now also
initializes "expr->offset".

              Linus

--001a11339974bbe0b404ffaaddb1
Content-Type: text/plain; charset=US-ASCII; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hydcwl300

IGV2YWx1YXRlLmMgICB8IDIwICsrKysrKysrKysrKysrKysrKy0tCiBleHByZXNzaW9uLmggfCAg
MSArCiAyIGZpbGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvZXZhbHVhdGUuYyBiL2V2YWx1YXRlLmMKaW5kZXggMDM5OTJkMDNhZTFkLi4z
MWE2YTQ5MzI5YjggMTAwNjQ0Ci0tLSBhL2V2YWx1YXRlLmMKKysrIGIvZXZhbHVhdGUuYwpAQCAt
MjIyMyw5ICsyMjIzLDEwIEBAIHN0YXRpYyB2b2lkIGNvbnZlcnRfaW5kZXgoc3RydWN0IGV4cHJl
c3Npb24gKmUpCiBzdGF0aWMgdm9pZCBjb252ZXJ0X2lkZW50KHN0cnVjdCBleHByZXNzaW9uICpl
KQogewogCXN0cnVjdCBleHByZXNzaW9uICpjaGlsZCA9IGUtPmlkZW50X2V4cHJlc3Npb247Ci0J
c3RydWN0IHN5bWJvbCAqc3ltID0gZS0+ZmllbGQ7CisJaW50IG9mZnNldCA9IGUtPm9mZnNldDsK
KwogCWUtPnR5cGUgPSBFWFBSX1BPUzsKLQllLT5pbml0X29mZnNldCA9IHN5bS0+b2Zmc2V0Owor
CWUtPmluaXRfb2Zmc2V0ID0gb2Zmc2V0OwogCWUtPmluaXRfbnIgPSAxOwogCWUtPmluaXRfZXhw
ciA9IGNoaWxkOwogfQpAQCAtMjI3Nyw2ICsyMjc4LDcgQEAgc3RhdGljIHN0cnVjdCBleHByZXNz
aW9uICpmaXJzdF9zdWJvYmplY3Qoc3RydWN0IHN5bWJvbCAqY3R5cGUsIGludCBjbGFzcywKIAkJ
bmV3ID0gYWxsb2NfZXhwcmVzc2lvbihlLT5wb3MsIEVYUFJfSURFTlRJRklFUik7CiAJCW5ldy0+
aWRlbnRfZXhwcmVzc2lvbiA9IGU7CiAJCW5ldy0+ZmllbGQgPSBuZXctPmN0eXBlID0gZmllbGQ7
CisJCW5ldy0+b2Zmc2V0ID0gZmllbGQtPm9mZnNldDsKIAl9CiAJKnYgPSBuZXc7CiAJcmV0dXJu
IG5ldzsKQEAgLTIzMjcsNiArMjMyOSw3IEBAIHN0YXRpYyBzdHJ1Y3QgZXhwcmVzc2lvbiAqY2hl
Y2tfZGVzaWduYXRvcnMoc3RydWN0IGV4cHJlc3Npb24gKmUsCiAJCQkJZXJyID0gInVua25vd24g
ZmllbGQgbmFtZSBpbiI7CiAJCQkJYnJlYWs7CiAJCQl9CisJCQllLT5vZmZzZXQgPSBvZmZzZXQ7
CiAJCQllLT5maWVsZCA9IGUtPmN0eXBlID0gY3R5cGU7CiAJCQlsYXN0ID0gZTsKIAkJCWlmICgh
ZS0+aWRlbnRfZXhwcmVzc2lvbikgewpAQCAtMjM4Niw2ICsyMzg5LDcgQEAgc3RhdGljIHN0cnVj
dCBleHByZXNzaW9uICpuZXh0X2Rlc2lnbmF0b3JzKHN0cnVjdCBleHByZXNzaW9uICpvbGQsCiAJ
fSBlbHNlIGlmIChvbGQtPnR5cGUgPT0gRVhQUl9JREVOVElGSUVSKSB7CiAJCXN0cnVjdCBleHBy
ZXNzaW9uICpjb3B5OwogCQlzdHJ1Y3Qgc3ltYm9sICpmaWVsZDsKKwkJaW50IG9mZnNldCA9IDA7
CiAKIAkJY29weSA9IG5leHRfZGVzaWduYXRvcnMob2xkLT5pZGVudF9leHByZXNzaW9uLAogCQkJ
CQlvbGQtPmN0eXBlLCBlLCB2KTsKQEAgLTIzOTcsNiArMjQwMSwxNyBAQCBzdGF0aWMgc3RydWN0
IGV4cHJlc3Npb24gKm5leHRfZGVzaWduYXRvcnMoc3RydWN0IGV4cHJlc3Npb24gKm9sZCwKIAkJ
CX0KIAkJCWNvcHkgPSBlOwogCQkJKnYgPSBuZXcgPSBhbGxvY19leHByZXNzaW9uKGUtPnBvcywg
RVhQUl9JREVOVElGSUVSKTsKKwkJCS8qCisJCQkgKiBXZSBjYW4ndCBuZWNlc3NhcmlseSB0cnVz
dCAiZmllbGQtPm9mZnNldCIsCisJCQkgKiBiZWNhdXNlIHRoZSBmaWVsZCBtaWdodCBiZSBpbiBh
biBhbm9ueW1vdXMKKwkJCSAqIHVuaW9uLCBhbmQgdGhlIGZpZWxkIG9mZnNldCBpcyB0aGVuIHRo
ZSBvZmZzZXQKKwkJCSAqIHdpdGhpbiB0aGF0IHVuaW9uLgorCQkJICoKKwkJCSAqIFRoZSAib2xk
LT5vZmZzZXQgLSBvbGQtPmZpZWxkLT5vZmZzZXQiCisJCQkgKiB3b3VsZCBiZSB0aGUgb2Zmc2V0
IG9mIHN1Y2ggYW4gYW5vbnltb3VzCisJCQkgKiB1bmlvbi4KKwkJCSAqLworCQkJb2Zmc2V0ID0g
b2xkLT5vZmZzZXQgLSBvbGQtPmZpZWxkLT5vZmZzZXQ7CiAJCX0gZWxzZSB7CiAJCQlmaWVsZCA9
IG9sZC0+ZmllbGQ7CiAJCQluZXcgPSBhbGxvY19leHByZXNzaW9uKGUtPnBvcywgRVhQUl9JREVO
VElGSUVSKTsKQEAgLTI0MDYsNiArMjQyMSw3IEBAIHN0YXRpYyBzdHJ1Y3QgZXhwcmVzc2lvbiAq
bmV4dF9kZXNpZ25hdG9ycyhzdHJ1Y3QgZXhwcmVzc2lvbiAqb2xkLAogCQluZXctPmV4cHJfaWRl
bnQgPSBmaWVsZC0+aWRlbnQ7CiAJCW5ldy0+aWRlbnRfZXhwcmVzc2lvbiA9IGNvcHk7CiAJCW5l
dy0+Y3R5cGUgPSBmaWVsZDsKKwkJbmV3LT5vZmZzZXQgPSBmaWVsZC0+b2Zmc2V0ICsgb2Zmc2V0
OwogCQljb252ZXJ0X2lkZW50KG9sZCk7CiAJfQogCXJldHVybiBuZXc7CmRpZmYgLS1naXQgYS9l
eHByZXNzaW9uLmggYi9leHByZXNzaW9uLmgKaW5kZXggZTMxZDE0MDUxZTAxLi44MGIzYmU1ZjUy
NmYgMTAwNjQ0Ci0tLSBhL2V4cHJlc3Npb24uaAorKysgYi9leHByZXNzaW9uLmgKQEAgLTE0OSw2
ICsxNDksNyBAQCBzdHJ1Y3QgZXhwcmVzc2lvbiB7CiAJCXN0cnVjdCBleHByZXNzaW9uX2xpc3Qg
KmV4cHJfbGlzdDsKIAkJLy8gRVhQUl9JREVOVElGSUVSCiAJCXN0cnVjdCAvKiBpZGVudF9leHBy
ICovIHsKKwkJCWludCBvZmZzZXQ7CiAJCQlzdHJ1Y3QgaWRlbnQgKmV4cHJfaWRlbnQ7CiAJCQlz
dHJ1Y3Qgc3ltYm9sICpmaWVsZDsKIAkJCXN0cnVjdCBleHByZXNzaW9uICppZGVudF9leHByZXNz
aW9uOwo=
--001a11339974bbe0b404ffaaddb1--
