From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: sparse-llvm duplicate declarations of data
Date: Tue, 14 Mar 2017 20:29:46 +0000
Message-ID: <CACXZuxcpyux92Jwe4HodmReoNwiefM7L0OnzX0XMDZ5gm6RAEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:33688 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbdCNU3t (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 14 Mar 2017 16:29:49 -0400
Received: by mail-io0-f174.google.com with SMTP id f84so7530669ioj.0
        for <linux-sparse@vger.kernel.org>; Tue, 14 Mar 2017 13:29:48 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

In the following test case:

static int once;
static int once = 1;
extern int printf(const char *, ...);
static int value(int *p)
{
 return *p;
}
int main(void)
{
 return value(&once) == 1 ? 0 : 1;
}

Sparse-llvm declares the global 'once' twice as there is a check
missing on whether the global has already been defined.

Regards
