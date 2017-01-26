From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Sparse-llvm question
Date: Thu, 26 Jan 2017 17:27:17 +0000
Message-ID: <CACXZuxeosx_qH3E5+gjnhx1czrSup5ZT0tm=kUqcp5u178twhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:35905 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753888AbdAZRfL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 26 Jan 2017 12:35:11 -0500
Received: by mail-vk0-f45.google.com with SMTP id t8so159446927vke.3
        for <linux-sparse@vger.kernel.org>; Thu, 26 Jan 2017 09:35:11 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org

Hi

I am hoping to reuse the Sparse-llvm component as a JIT compiler for C
in an application. I was playing around with it a bit and hit an
immediate issue. For instance compilation of a simple program like
this fails:

const char ident[] = "";

Is there a list of what works and what doesn't anywhere?

Thanks and Regards
Dibyendu
