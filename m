From: Christopher Li <sparse@chrisli.org>
Subject: Re: Sparse parsing question: string literal
Date: Sun, 20 Aug 2017 09:05:44 -0400
Message-ID: <CANeU7Qkq60MA_ufvPsx6dXvr5ZW-kVaGmwVVQ8gQY1g=srZ1MA@mail.gmail.com>
References: <CACXZuxcvbCc+eOyqzrUUs4qkTpS705u065nc5=H8DLJ9AQnCEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f175.google.com ([209.85.161.175]:33219 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752844AbdHTNFq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 20 Aug 2017 09:05:46 -0400
Received: by mail-yw0-f175.google.com with SMTP id h127so10853642ywf.0
        for <linux-sparse@vger.kernel.org>; Sun, 20 Aug 2017 06:05:45 -0700 (PDT)
In-Reply-To: <CACXZuxcvbCc+eOyqzrUUs4qkTpS705u065nc5=H8DLJ9AQnCEw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 20, 2017 at 8:31 AM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
> Hi,
>
> I am looking at the parse tree for following snippet:
>
> void main(int argc, const char *argv[])
> {
> 5;
> 6.5;
> "hello";
> }
>
> I see that 5 is treated as EXPR_VALUE, 6.5 as EXPR_FVALUE, but "hello"
> is treated as EXPR_SYMBOL. Why is that?

Because "hello" is array of char from type point of view.

It is same as
char no_ident [] = {'h', 'e', 'l', 'l', 'o', '\0'};

except it does not have the name(sym->ident) for this symbol.

Chris
