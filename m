From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Some random thoughts regarding the SSA paper
Date: Wed, 16 Aug 2017 13:47:03 +0100
Message-ID: <CACXZuxf2Nh=S3bmF+uCDwVaPbHDF44Vb2TPPuMwdXsEBBGTwGw@mail.gmail.com>
References: <CANeU7QmcVS_8oko6RhG_g_97AjUNVYa=KDqDocbXL5ney=mrJw@mail.gmail.com>
 <CACXZuxdnMFA5HPg3GXLWXP6+Mk8+UikcZsJZH8DJ227PYHyEfQ@mail.gmail.com>
 <CANeU7Q=r4A8WQrqaACQ2iak9CcEXds20peJrr1AqJ8tyxCF56Q@mail.gmail.com>
 <CACXZuxcjBJdM2Sy4KWjaU1Oofr+S3=1vRkznOd9WatycuOSWsw@mail.gmail.com> <CANeU7Q=byg+e9qKhyO9cuVgrveqmWUajv_e6AWuK4PsJV4+T4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f175.google.com ([209.85.217.175]:35734 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751620AbdHPMrE (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Aug 2017 08:47:04 -0400
Received: by mail-ua0-f175.google.com with SMTP id d29so13339133uai.2
        for <linux-sparse@vger.kernel.org>; Wed, 16 Aug 2017 05:47:03 -0700 (PDT)
In-Reply-To: <CANeU7Q=byg+e9qKhyO9cuVgrveqmWUajv_e6AWuK4PsJV4+T4g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>

Hi Chris,

On 16 August 2017 at 13:42, Christopher Li <sparse@chrisli.org> wrote:
> On Wed, Aug 16, 2017 at 8:24 AM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>>
>> The paper says that the algorithm creates correct SSA for all
>> programs. Specifically quoting:
>>
>> <quote>
>> prove that the SSA construction algorithm constructs pruned SSA form
>> for all programs and minimal SSA form for programs with reducible
>> control flow
>> <endquote>
>>
>> Secondly even for irreducible control flow, it provides an algorithm
>> for creating minimal SSA in section 3.2, right?
>
> It do provide a solution. and the price is high. The complexity is
> O(B*B*V*V).  Go look at page 15 of the paper.
>

That is only if you want a minimal SSA right? Do you need one? Again I
suggest you try out Luc's implementation which appears to work fine -
and it doesn't do this extra pass I believe.

Regards
Dibyendu
