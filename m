From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Investigating a problem
Date: Fri, 18 Aug 2017 23:43:04 +0100
Message-ID: <CACXZuxeHWAviEDKdmVepGnXyU9qnGZzOgfkh696x1Au_rhANNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f181.google.com ([209.85.217.181]:38532 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750969AbdHRWnF (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 18:43:05 -0400
Received: by mail-ua0-f181.google.com with SMTP id n29so8494224uai.5
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 15:43:05 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

I am investigating a problem with following code:

extern int testme(int a, int b);

int testme(int a, int b)
{
if (a == b)
return 0;
return 5;
}

The CBR instruction appears to get a NULL type.

I would like to know if this works correctly in Sparse LLVM (right now
I can't build Sparse LLVM hence I cannot test this).

Thanks and Regards
Dibyendu
