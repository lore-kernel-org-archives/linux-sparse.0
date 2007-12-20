From: "Marko Kreen" <markokr@gmail.com>
Subject: [patch] Mac OS X specs for cgcc
Date: Thu, 20 Dec 2007 15:50:00 +0200
Message-ID: <e51f66da0712200550l620838f5h727b711a3abb85a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_19169_27260244.1198158600525"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:32994 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757973AbXLTNuC (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 20 Dec 2007 08:50:02 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1733681nfb.21
        for <linux-sparse@vger.kernel.org>; Thu, 20 Dec 2007 05:50:01 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

------=_Part_19169_27260244.1198158600525
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch adds MacOS X (darwin) specific defines to cgcc.

Only suspicios aspect about it is that OSX system include
files expect either __LITTLE_ENDIAN__ or __BIG_ENDIAN__ to be
defined to show endianess.  I added a arch switch to darwin
section to pick this up to avoid polluting general i86 and x86_64
sections.  (note: i dont speak perl and i dont have any ppc32/64
to test it on).

Somwhat simpler would be to put __LITTLE_ENDIAN__ unconditionally
to darwin section on the grounds that ppc is unsupported anyway,
but if the support appears it may be better to have the switch
available already.

-- 
marko

------=_Part_19169_27260244.1198158600525
Content-Type: application/octet-stream; name=cgcc.macos.specs.diff
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fafcnrc3
Content-Disposition: attachment; filename=cgcc.macos.specs.diff

ZGlmZiAtLWdpdCBhL2NnY2MgYi9jZ2NjCmluZGV4IDlhY2Y0OTguLmQ0YzUwZjggMTAwNzU1Ci0t
LSBhL2NnY2MKKysrIGIvY2djYwpAQCAtMjE0LDYgKzIxNCwxNCBAQCBzdWIgYWRkX3NwZWNzIHsK
ICAgICB9IGVsc2lmICgkc3BlYyBlcSAnbGludXgnKSB7CiAJcmV0dXJuICZhZGRfc3BlY3MgKCd1
bml4JykgLgogCSAgICAnIC1EX19saW51eF9fPTEgLURfX2xpbnV4PTEgLURsaW51eD1saW51eCc7
CisgICAgfSBlbHNpZiAoJHNwZWMgZXEgJ2RhcndpbicpIHsKKwlteSAkb3N4ID0gJyAtRF9fTUFD
SF9fPTEgLURfX0FQUExFX189MSAtRF9fQVBQTEVfQ0NfXz0xIC1EX19EWU5BTUlDX189MSc7CisJ
bXkgJGFyY2ggPSBgdW5hbWUgLW1gOworCWlmICgkYXJjaCA9fiAvcHBjL2kpIHsKKwkgIHJldHVy
biAoJG9zeCAuICIgLURfX0JJR19FTkRJQU5fXyIpOworCX0gZWxzZSB7CisJICByZXR1cm4gKCRv
c3ggLiAiIC1EX19MSVRUTEVfRU5ESUFOX18iKTsKKwl9CiAgICAgfSBlbHNpZiAoJHNwZWMgZXEg
J3VuaXgnKSB7CiAJcmV0dXJuICcgLUR1bml4PTEgLURfX3VuaXg9MSAtRF9fdW5peF9fPTEnOwog
ICAgIH0gZWxzaWYgKCAkc3BlYyA9fiAvXmN5Z3dpbi8pIHsK
------=_Part_19169_27260244.1198158600525--
