From: Christopher Li <sparse@chrisli.org>
Subject: Fwd: Upcoming sparse release RC5
Date: Sat, 5 Aug 2017 12:16:00 -0400
Message-ID: <CANeU7QnpBMRuVBWOH+LnpVFvCKuDFPHxvqeKR9VcA0YR3mSGqQ@mail.gmail.com>
References: <CANeU7QmZXY5Q4GmBMh42WpdiRyYfA=Ddpvjk_35=_Rmhb=RMiA@mail.gmail.com>
 <CACXZuxdLX3r+LrhBJYnC54HZhTN152JkPZAQGqhoQwEFjcyiYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:36319 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751226AbdHEQQB (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 5 Aug 2017 12:16:01 -0400
Received: by mail-pg0-f52.google.com with SMTP id v77so18864276pgb.3
        for <linux-sparse@vger.kernel.org>; Sat, 05 Aug 2017 09:16:01 -0700 (PDT)
In-Reply-To: <CACXZuxdLX3r+LrhBJYnC54HZhTN152JkPZAQGqhoQwEFjcyiYw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Adding the sparse mailing list.

Agree. We can add the testsuilt validate IR and LLVM IR to the project list.

If we do more complicate validation, we might consider using a more text
processing friendly  language to do the validation.  I would pick python
if I am going to code it, but that is just me.

Chris


---------- Forwarded message ----------
From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Date: Sat, Aug 5, 2017 at 12:09 PM
Subject: Re: Upcoming sparse release RC5
To: Christopher Li <sparse@chrisli.org>


Hi Chris,

On 5 August 2017 at 16:46, Christopher Li <sparse@chrisli.org> wrote:
>     We can discuss what we want to see in sparse in the future.

I think that the automated test suite needs to be enhanced to a)
validate IR, and b) validate LLVM output. At the moment most tests do
not appear to actually verify that the generated IR / simplifications
are correct. This makes it risky and error prone to make changes. The
LLVM verification can be an additional validation step to ensure that
the generated code actually runs correctly.

Regards
Dibyendu
