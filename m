From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Sparse parsing question: string literal
Date: Sun, 20 Aug 2017 14:12:25 +0100
Message-ID: <CACXZuxd755Q2FK4Br36nVyMjatiQGLjhKAhWS05Erm1X=bt1XA@mail.gmail.com>
References: <CACXZuxcvbCc+eOyqzrUUs4qkTpS705u065nc5=H8DLJ9AQnCEw@mail.gmail.com>
 <CANeU7Qkq60MA_ufvPsx6dXvr5ZW-kVaGmwVVQ8gQY1g=srZ1MA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f176.google.com ([209.85.217.176]:38735 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752903AbdHTNM0 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 20 Aug 2017 09:12:26 -0400
Received: by mail-ua0-f176.google.com with SMTP id n29so15978864uai.5
        for <linux-sparse@vger.kernel.org>; Sun, 20 Aug 2017 06:12:26 -0700 (PDT)
In-Reply-To: <CANeU7Qkq60MA_ufvPsx6dXvr5ZW-kVaGmwVVQ8gQY1g=srZ1MA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Chris,

On 20 August 2017 at 14:05, Christopher Li <sparse@chrisli.org> wrote:
> On Sun, Aug 20, 2017 at 8:31 AM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>> I am looking at the parse tree for following snippet:
>>
>> void main(int argc, const char *argv[])
>> {
>> 5;
>> 6.5;
>> "hello";
>> }
>>
>> I see that 5 is treated as EXPR_VALUE, 6.5 as EXPR_FVALUE, but "hello"
>> is treated as EXPR_SYMBOL. Why is that?
>
> Because "hello" is array of char from type point of view.
>
> It is same as
> char no_ident [] = {'h', 'e', 'l', 'l', 'o', '\0'};
>
> except it does not have the name(sym->ident) for this symbol.
>

I see - so every string literal results in an un-named symbol, whose
initializer is set to the string expression?

Regards
Dibyendu
