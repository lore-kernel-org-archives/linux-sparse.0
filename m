From: Christopher Li <sparse@chrisli.org>
Subject: Re: Sparse parsing question: string literal
Date: Sun, 20 Aug 2017 12:00:09 -0400
Message-ID: <CANeU7QmGO7BCDFYhsBmpipB4TYPXWybd9txDOq9Fkw91HKHtug@mail.gmail.com>
References: <CACXZuxcvbCc+eOyqzrUUs4qkTpS705u065nc5=H8DLJ9AQnCEw@mail.gmail.com>
 <CANeU7Qkq60MA_ufvPsx6dXvr5ZW-kVaGmwVVQ8gQY1g=srZ1MA@mail.gmail.com> <ccf4cac2-003f-f856-28db-49dacae374b6@knosof.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f176.google.com ([209.85.161.176]:33894 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753064AbdHTQAK (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 20 Aug 2017 12:00:10 -0400
Received: by mail-yw0-f176.google.com with SMTP id s143so80559677ywg.1
        for <linux-sparse@vger.kernel.org>; Sun, 20 Aug 2017 09:00:10 -0700 (PDT)
In-Reply-To: <ccf4cac2-003f-f856-28db-49dacae374b6@knosof.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Derek M Jones <derek@knosof.co.uk>
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Aug 20, 2017 at 11:16 AM, Derek M Jones <derek@knosof.co.uk> wrote:
>
> You forgot the static keyword:
> Sentence 903:
> http://c0x.coding-guidelines.com/6.4.5.html

Thanks for catching that. You are right. They need to be static as well.
I kind of expect that to be const as well. The stander did not put const
as requirement. Just said modify the string is undefined.

>
> But depending on context a conversion occurs.
> Sentence 729:
> http://c0x.coding-guidelines.com/6.3.2.1.html
>
> and your example is one where such a conversion occurs.

Thanks for pointing it out. Interesting read.

BTW, unrelated to string literal but relate to 729.

Do you have any comment on sparse giving warning of:
sizeof(function_name)?

The programmer usually mean sizeof(&function_name).
But 729 said sizeof is such a special case the function degenerate
into pointers does not work inside sizeof().

Should sparse give warning for sizeof(function_name) at all?

Thanks

Chris
