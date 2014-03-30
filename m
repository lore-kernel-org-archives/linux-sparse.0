From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse API
Date: Sun, 30 Mar 2014 10:05:07 -0700
Message-ID: <CANeU7QmZAhkaV4qqHikkJ=N4MdKbfr8bd4FjQiP0Owm45A6fow@mail.gmail.com>
References: <a4bb115e6008a0f9aa81374860ce965c.squirrel@webmail.frugalware.org>
	<CANeU7QkADwLGCv755PZZt64nHATssTp6UDf==yj3CEWZpW5E1w@mail.gmail.com>
	<d0024909a134f1a25762bfcc70cd8210.squirrel@webmail.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:55016 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbaC3RFI (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 30 Mar 2014 13:05:08 -0400
Received: by mail-qc0-f182.google.com with SMTP id e16so7883765qcx.41
        for <linux-sparse@vger.kernel.org>; Sun, 30 Mar 2014 10:05:07 -0700 (PDT)
In-Reply-To: <d0024909a134f1a25762bfcc70cd8210.squirrel@webmail.frugalware.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: ryuo@frugalware.org
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Adding the sparse mailing list.

Ryuo want to access the typedef symbol names before it get replaced
with the underneath ctype.

On Sun, Mar 30, 2014 at 12:04 AM,  <ryuo@frugalware.org> wrote:
>> I think what you want is the type before the evaluation stage.
>> You can skip the evaluation step then you will have the original type
>> with the typedef name.
>
> That may work. Would it also stop the evaluation of other things, such as
> the result of a constant expression? Also, how would I achieve this? I
> don't think I saw this anywhere in the existing API.

You just call __sparse instead of sparse() to get the list of symbol
without the evaluation stage. Yes it will skip the constant evaluation
as well.

>
>> In the current code, the type evaluation will just replace the typedef
>> with the destination type. It seems to me that you just want to skip that
>> step. Will that work for you?
>
> Possibly, but it depends on how I could do this without changing the
> default behavior.

Can you give me more back ground of why you want to do this?

One way come into mind is that, you can call __sparse first, then
tag and mark whatever typedef you want. Then call evaluate_symbol_list()
from your program to perform the evaluation stage.

If that does not work, what you really need is some kind of
hooks to get callback when the typedef replacement happens.


Chris
