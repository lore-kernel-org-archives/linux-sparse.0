From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Cast to double being removed
Date: Fri, 17 Mar 2017 00:00:00 +0000
Message-ID: <CACXZuxdNCM5wWvnYhvt65WaX6hSR_fTnaqd7=pv8O81NWoYQ_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:36898 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752993AbdCQAGJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 16 Mar 2017 20:06:09 -0400
Received: by mail-it0-f41.google.com with SMTP id g138so7926414itb.0
        for <linux-sparse@vger.kernel.org>; Thu, 16 Mar 2017 17:06:08 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

In this simple example:

extern int printf(const char *, ...);
int main(void)
{
    printf("%f\n", (double)-1);
    return 0;
}

The linearized output is:

main:
.L0:
        <entry-point>
        symaddr.64  %r1 <- <anon symbol:000001BAAB487258>
        call.32     %r2 <- printf, %r1, $-1
        ret.32      $0

The cast to double has been removed. I am trying to understand where
this is happening as it seems to happen quite early on. Any tips on
where I should look?

Thanks and Regards
Dibyendu
