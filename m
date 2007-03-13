From: "Russ Cox" <rsc@swtch.com>
Subject: constness bug in include/linux/compiler.h
Date: Tue, 13 Mar 2007 18:23:45 -0400
Message-ID: <ee9e417a0703131523x2cc701f7l7938624175bf1fe0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.246]:27358 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933779AbXCMWXp (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 13 Mar 2007 18:23:45 -0400
Received: by an-out-0708.google.com with SMTP id b33so2062462ana
        for <linux-sparse@vger.kernel.org>; Tue, 13 Mar 2007 15:23:45 -0700 (PDT)
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Tom Bergan <tbergan@ucla.edu>

Probably sparse just doesn't pay attention to const,
but shouldn't the definitions of __chk_user_ptr
and __chk_io_ptr be

    extern void __chk_user_ptr(const void __user *);
    extern void __chk_io_ptr(const void __iomem *);

instead of

    extern void __chk_user_ptr(void __user *);
    extern void __chk_io_ptr(void __iomem *);

?

Russ
