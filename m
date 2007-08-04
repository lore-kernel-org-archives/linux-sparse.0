From: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: [patch] improve flag handling
Date: Sat, 4 Aug 2007 01:02:18 -0400
Message-ID: <8bd0f97a0708032202r2615f659v514667337c809d05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_99775_28796752.1186203738211"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.247]:52094 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbXHDFCT (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 4 Aug 2007 01:02:19 -0400
Received: by an-out-0708.google.com with SMTP id d31so192398and
        for <linux-sparse@vger.kernel.org>; Fri, 03 Aug 2007 22:02:18 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

------=_Part_99775_28796752.1186203738211
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

the attached patch tweaks the makefile so that it respects CFLAGS set
in the environment and it makes sure to link the shared libsparse with
$(LDFLAGS)
-mike

------=_Part_99775_28796752.1186203738211
Content-Type: application/octet-stream; name="sparse-9999-build.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="sparse-9999-build.patch"
X-Attachment-Id: f_f4xn2nw5

U2lnbmVkLW9mZi1ieTogTWlrZSBGcnlzaW5nZXIgPHZhcGllckBnZW50b28ub3JnPgotLS0KZGlm
ZiAtLWdpdCBhL01ha2VmaWxlIGIvTWFrZWZpbGUKaW5kZXggOTdiZmUzYi4uMWUwNjc5NCAxMDA2
NDQKLS0tIGEvTWFrZWZpbGUKKysrIGIvTWFrZWZpbGUKQEAgLTIsOSArMiwxMCBAQCBWRVJTSU9O
PTAuMwogCiBPUz1saW51eAogCi1DQz1nY2MKLUNGTEFHUz0tTzIgLWZpbmxpbmUtZnVuY3Rpb25z
IC1nIC1XYWxsIC1Xd3JpdGUtc3RyaW5ncwotTERGTEFHUz0tZworQ0MgPz0gZ2NjCitDRkxBR1Mg
Pz0gLU8yIC1maW5saW5lLWZ1bmN0aW9ucyAtZworQ0ZMQUdTICs9IC1XYWxsIC1Xd3JpdGUtc3Ry
aW5ncworTERGTEFHUyA/PSAtZwogQVI9YXIKIAogSEFWRV9MSUJYTUw9JChzaGVsbCBwa2ctY29u
ZmlnIC0tZXhpc3RzIGxpYnhtbC0yLjAgJiYgZWNobyAneWVzJykKQEAgLTEyOSw3ICsxMzAsNyBA
QCAkKExJQl9GSUxFKTogJChMSUJfT0JKUykKIAkkKFFVSUVUX0FSKSQoQVIpIHJjcyAkQCAkKExJ
Ql9PQkpTKQogCiAkKFNMSUJfRklMRSk6ICQoTElCX09CSlMpCi0JJChRVUlFVF9MSU5LKSQoQ0Mp
IC1zaGFyZWQgLW8gJEAgJChMSUJfT0JKUykKKwkkKFFVSUVUX0xJTkspJChDQykgJChMREZMQUdT
KSAtV2wsLXNvbmFtZSwkQCAtc2hhcmVkIC1vICRAICQoTElCX09CSlMpCiAKIGV2YWx1YXRlLm86
ICQoTElCX0gpCiBleHByZXNzaW9uLm86ICQoTElCX0gpCg==
------=_Part_99775_28796752.1186203738211--
