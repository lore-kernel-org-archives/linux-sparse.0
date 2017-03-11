From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: sparse-llvm op_setval implementation is missing
Date: Sat, 11 Mar 2017 23:41:12 +0000
Message-ID: <CACXZuxddgVd=bUoNvRZnCndee8E4o=U0YECg3dnfXoEZTAghbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:33910 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933261AbdCKXlN (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 18:41:13 -0500
Received: by mail-io0-f173.google.com with SMTP id g6so67119771ioj.1
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 15:41:13 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

I am trying to run following test case:

extern int printf(const char *fmt, ...);
int main(void)
{
 // variables
 float a = 12.34 + 56.78;
 printf("%f\n", a);
 return 0;
}

This fails as SETVAL is not implemented.

Regards
