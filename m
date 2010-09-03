From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Fixup and cleanup of the modifier_string() function (was
 Re: modifier_string() inconsistency with modifiers)
Date: Fri, 3 Sep 2010 02:13:38 -0700
Message-ID: <AANLkTikOGhqVu8+A_kT=95AX=10H_pxhwqLmQr+08zzm@mail.gmail.com>
References: <1282300429.10440.230.camel@thorin>
	<AANLkTikugbBQ1gYVAdFRxWVmEX-odjq+Y5wA4mnN7Vnj@mail.gmail.com>
	<1282466539.5200.1.camel@thorin>
	<AANLkTinT5xhr+C4H71CWx3R9EqHy6ycp8gskjUqjts2Q@mail.gmail.com>
	<1282574577.5200.18.camel@thorin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015174c17b49e9f9f048f5758e3
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:39440 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537Ab0ICJNk (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 3 Sep 2010 05:13:40 -0400
Received: by ewy23 with SMTP id 23so892837ewy.19
        for <linux-sparse@vger.kernel.org>; Fri, 03 Sep 2010 02:13:38 -0700 (PDT)
In-Reply-To: <1282574577.5200.18.camel@thorin>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Bernd Petrovitsch <bernd@sysprog.at>
Cc: linux-sparse@vger.kernel.org

--0015174c17b49e9f9f048f5758e3
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Aug 23, 2010 at 7:42 AM, Bernd Petrovitsch <bernd@sysprog.at> wrote:
> Fixup and cleanup of the modifier_string() function
>
> This patch does:
> - it fixes the modifier_string() function
> - The array with the names is made "static".


Sorry for the late reply.

Your patch does not apply to the chrisl repository. I also notice that
if modifier
is zero, it will return buffer without initialized. Well the modifier
is not supposed
to be zero, but still.

Another thing in the patch is that I don't want to move the modifier
bits for just the debug
function. It is expected to have more change in the modifier bits. How about
this patch? I start with your patch and end up like this.

If that works for you, please sign it off and I will check it in.

Thanks,

Chris

--0015174c17b49e9f9f048f5758e3
Content-Type: application/octet-stream; name="mod-string.patch"
Content-Disposition: attachment; filename="mod-string.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gdmtpfr80

ZGlmZiAtLWdpdCBhL3Nob3ctcGFyc2UuYyBiL3Nob3ctcGFyc2UuYwppbmRleCBkN2I1MDJkLi5j
OTdkZWJlIDEwMDY0NAotLS0gYS9zaG93LXBhcnNlLmMKKysrIGIvc2hvdy1wYXJzZS5jCkBAIC05
NSwyOSArOTUsNTUgQEAgdm9pZCBkZWJ1Z19zeW1ib2woc3RydWN0IHN5bWJvbCAqc3ltKQogY29u
c3QgY2hhciAqbW9kaWZpZXJfc3RyaW5nKHVuc2lnbmVkIGxvbmcgbW9kKQogewogCXN0YXRpYyBj
aGFyIGJ1ZmZlclsxMDBdOwotCWNoYXIgKnAgPSBidWZmZXI7Ci0JY29uc3QgY2hhciAqcmVzLCoq
cHRyLCAqbmFtZXNbXSA9IHsKLQkJImF1dG8iLCAicmVnaXN0ZXIiLCAic3RhdGljIiwgImV4dGVy
biIsCi0JCSJjb25zdCIsICJ2b2xhdGlsZSIsICJbc2lnbmVkXSIsICJbdW5zaWduZWRdIiwKLQkJ
IltjaGFyXSIsICJbc2hvcnRdIiwgIltsb25nXSIsICJbbG9uZyBsb25nXSIsCi0JCSJbdHlwZWRl
Zl0iLCAiW3N0cnVjdG9mXSIsICJbdW5pb25vZl0iLCAiW2VudW1dIiwKLQkJIlt0eXBlb2ZdIiwg
IlthdHRyaWJ1dGVdIiwgImlubGluZSIsICJbYWRkcmVzc2FibGVdIiwKLQkJIltub2Nhc3RdIiwg
Iltub2RlcmVmXSIsICJbYWNjZXNzZWRdIiwgIlt0b3BsZXZlbF0iLAotCQkiW2xhYmVsXSIsICJb
YXNzaWduZWRdIiwgIlt0eXBlXSIsICJbc2FmZV0iLAotCQkiW3VzZXJ0eXBlXSIsICJbZm9yY2Vd
IiwgIltleHBsaWNpdGx5LXNpZ25lZF0iLAotCQlOVUxMCisJaW50IGxlbiA9IDA7CisJaW50IGk7
CisJc3RydWN0IG1vZF9uYW1lIHsKKwkJdW5zaWduZWQgbG9uZyBtb2Q7CisJCWNvbnN0IGNoYXIg
Km5hbWU7CisJfSAqbTsKKworCXN0YXRpYyBzdHJ1Y3QgbW9kX25hbWUgbW9kX25hbWVzW10gPSB7
CisJCXtNT0RfQVVUTywJCSJhdXRvIn0sCisJCXtNT0RfUkVHSVNURVIsCQkicmVnaXN0ZXIifSwK
KwkJe01PRF9TVEFUSUMsCQkic3RhdGljIn0sCisJCXtNT0RfRVhURVJOLAkJImV4dGVybiJ9LAor
CQl7TU9EX0NPTlNULAkJImNvbnN0In0sCisJCXtNT0RfVk9MQVRJTEUsCQkidm9sYXRpbGUifSwK
KwkJe01PRF9TSUdORUQsCQkiW3NpZ25lZF0ifSwKKwkJe01PRF9VTlNJR05FRCwJCSJbdW5zaWdu
ZWRdIn0sCisJCXtNT0RfQ0hBUiwJCSJbY2hhcl0ifSwKKwkJe01PRF9TSE9SVCwJCSJbc2hvcnRd
In0sCisJCXtNT0RfTE9ORywJCSJbbG9uZ10ifSwKKwkJe01PRF9MT05HTE9ORywJCSJbbG9uZyBs
b25nXSJ9LAorCQl7TU9EX0xPTkdMT05HTE9ORywJIltsb25nIGxvbmcgbG9uZ10ifSwKKwkJe01P
RF9UWVBFREVGLAkJIlt0eXBlZGVmXSJ9LAorCQl7TU9EX1RMUywJCSJbdGxzXSJ9LAorCQl7TU9E
X0lOTElORSwJCSJpbmxpbmUifSwKKwkJe01PRF9BRERSRVNTQUJMRSwJIlthZGRyZXNzYWJsZV0i
fSwKKwkJe01PRF9OT0NBU1QsCQkiW25vY2FzdF0ifSwKKwkJe01PRF9OT0RFUkVGLAkJIltub2Rl
cmVmXSJ9LAorCQl7TU9EX0FDQ0VTU0VELAkJIlthY2Nlc3NlZF0ifSwKKwkJe01PRF9UT1BMRVZF
TCwJCSJbdG9wbGV2ZWxdIn0sCisJCXtNT0RfQVNTSUdORUQsCQkiW2Fzc2lnbmVkXSJ9LAorCQl7
TU9EX1RZUEUsCQkiW3R5cGVdIn0sCisJCXtNT0RfU0FGRSwJCSJbc2FmZV0ifSwKKwkJe01PRF9V
U0VSVFlQRSwJCSJbdXNlcnR5cGVdIn0sCisJCXtNT0RfTk9SRVRVUk4sCQkiW25vcmV0dXJuXSJ9
LAorCQl7TU9EX0VYUExJQ0lUTFlfU0lHTkVELAkiW2V4cGxpY2l0bHktc2lnbmVkXSJ9LAorCQl7
TU9EX0JJVFdJU0UsCQkiW2JpdHdpc2VdIn0sCiAJfTsKLQlwdHIgPSBuYW1lczsKLQl3aGlsZSAo
KHJlcyA9ICpwdHIrKykgIT0gTlVMTCkgewotCQlpZiAobW9kICYgMSkgeworCisJZm9yIChpID0g
MDsgaSA8IEFSUkFZX1NJWkUobW9kX25hbWVzKTsgaSsrKSB7CisJCW0gPSBtb2RfbmFtZXMgKyBp
OworCQlpZiAobW9kICYgbS0+bW9kKSB7CiAJCQljaGFyIGM7Ci0JCQl3aGlsZSAoKGMgPSAqcmVz
KyspICE9ICdcMCcpCi0JCQkJKnArKyA9IGM7Ci0JCQkqcCsrID0gJyAnOworCQkJY29uc3QgY2hh
ciAqbmFtZSA9IG0tPm5hbWU7CisJCQl3aGlsZSAoKGMgPSAqbmFtZSsrKSAhPSAnXDAnICYmIGxl
biArIDIgPCBzaXplb2YgYnVmZmVyKQorCQkJCWJ1ZmZlcltsZW4rK10gPSBjOworCQkJYnVmZmVy
W2xlbisrXSA9ICcgJzsKIAkJfQotCQltb2QgPj49IDE7CiAJfQotCSpwID0gMDsKKwlidWZmZXJb
bGVuXSA9IDA7CiAJcmV0dXJuIGJ1ZmZlcjsKIH0KIAo=
--0015174c17b49e9f9f048f5758e3--
