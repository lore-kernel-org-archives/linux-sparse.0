From: Bart Van Assche <bvanassche@acm.org>
Subject: Sparse complains about __constant_cpu_to_be32(1)
Date: Sat, 30 Oct 2010 11:57:09 +0200
Message-ID: <AANLkTin2dPQQNaGC48QrvxU0dZvYf1znC442v0gBGUQ0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44840 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937Ab0J3J53 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 30 Oct 2010 05:57:29 -0400
Received: by iwn10 with SMTP id 10so4802367iwn.19
        for <linux-sparse@vger.kernel.org>; Sat, 30 Oct 2010 02:57:29 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse <linux-sparse@vger.kernel.org>
Cc: Vladislav Bolkhovitin <vst@vlnb.net>

Hello,

Even with the most recent sparse version, I see the following when
running sparse on an x86_64 system:
* sparse does not complain about __constant_cpu_to_be32(0xFFFFFFFF),
as expected.
* sparse complains about __constant_cpu_to_be32(1), which I did not
expect. The warning sparse prints is:

warning: cast truncates bits from constant value (1000000 becomes 0)

Can anyone tell me whether that's a bug or a feature ?

Thanks,

Bart.
