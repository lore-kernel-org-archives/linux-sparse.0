From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Query: clarification of a comment in linearize.c
Date: Thu, 10 Aug 2017 19:19:41 +0100
Message-ID: <CACXZuxc24O=0aw0b5UPHBt3Dh202smLZZPS5gm4obOV_BdQ4eA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:38235 "EHLO
        mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbdHJSTm (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Aug 2017 14:19:42 -0400
Received: by mail-vk0-f43.google.com with SMTP id g189so5744787vke.5
        for <linux-sparse@vger.kernel.org>; Thu, 10 Aug 2017 11:19:42 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

I see following comment in linearize.c:

* Linearize - walk the statement tree (but _not_ the expressions)
* to generate a linear version of it and the basic blocks.
*
* NOTE! We're not interested in the actual sub-expressions yet,
* even though they can generate conditional branches and
* subroutine calls. That's all "local" behaviour.

Is this statement still true - i.e. only statements are linearized?

Thanks and Regards
Dibyendu
