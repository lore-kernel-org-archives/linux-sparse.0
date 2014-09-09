From: Nash <nash@nash.id.au>
Subject: Sparse doesn't seem to check __must_hold macros.
Date: Wed, 10 Sep 2014 07:16:31 +1000
Message-ID: <CADgd-zq55cvmV5bvXLEN8OaLaCNw4tGM2ZwS3Zufy543d_oK+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=047d7bf0e0a00d05940502a873d6
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:37411 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176AbaIIVQc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 9 Sep 2014 17:16:32 -0400
Received: by mail-qc0-f170.google.com with SMTP id l6so135270qcy.15
        for <linux-sparse@vger.kernel.org>; Tue, 09 Sep 2014 14:16:31 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

--047d7bf0e0a00d05940502a873d6
Content-Type: text/plain; charset=UTF-8

Hello,

I was just testing sparse on a large (non-linux) code base using the
__must_hold macro (eg __attribute__((context, 1, 1))).

However I don't seem to be able to trigger a warning from it.

I've attached a test case below, is there some magic I need to do get sparse
to trigger on this case.  I also note there are currently no tests in
validation that check for this case.

Regards,
nash

--047d7bf0e0a00d05940502a873d6
Content-Type: text/x-csrc; charset=US-ASCII; name="sparse_context.c"
Content-Disposition: attachment; filename="sparse_context.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hzvqnc7f0

CnN0YXRpYyBpbnQgbXVzdF9ob2xkKGludCB4KSBfX2F0dHJpYnV0ZV9fKChjb250ZXh0KDEsMSkp
KSB7CglpbnQgejsKCglyZXR1cm4geCAqIDc7Cn0KCnN0YXRpYyBpbnQgcmVsZWFzZShpbnQgeCkg
X19hdHRyaWJ1dGVfXygoY29udGV4dCgxLCAwKSkpIHsKCV9fY29udGV4dF9fKC0xKTsKCXJldHVy
biAwOwp9CgpzdGF0aWMgaW50IGFjcXVpcmVzaWxlbnRseShpbnQgeCkgewoJX19jb250ZXh0X18o
MSk7CgoJcmV0dXJuIDE7Cn0KCmludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndikgewoJbXVz
dF9ob2xkKDgpOwoJX19jb250ZXh0X18oMSk7CgltdXN0X2hvbGQoMCk7CglfX2NvbnRleHRfXygt
MSk7CglyZXR1cm4gMDsKfQo=
--047d7bf0e0a00d05940502a873d6--
