From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Investigating a problem
Date: Sat, 19 Aug 2017 00:14:50 +0100
Message-ID: <CACXZuxdNMAG38F7y6qqPN6q4ZDuzviKsmF1b_or1R5P74nUE5Q@mail.gmail.com>
References: <CACXZuxeHWAviEDKdmVepGnXyU9qnGZzOgfkh696x1Au_rhANNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:37962 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751076AbdHRXOw (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Aug 2017 19:14:52 -0400
Received: by mail-vk0-f53.google.com with SMTP id g189so36756085vke.5
        for <linux-sparse@vger.kernel.org>; Fri, 18 Aug 2017 16:14:52 -0700 (PDT)
In-Reply-To: <CACXZuxeHWAviEDKdmVepGnXyU9qnGZzOgfkh696x1Au_rhANNw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

On 18 August 2017 at 23:43, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> I am investigating a problem with following code:
>
> extern int testme(int a, int b);
>
> int testme(int a, int b)
> {
> if (a == b)
> return 0;
> return 5;
> }
>
> The CBR instruction appears to get a NULL type.
>
> I would like to know if this works correctly in Sparse LLVM (right now
> I can't build Sparse LLVM hence I cannot test this).
>

Apologies please ignore - this is likely not the real problem. I will
get back with more details.

Regards
