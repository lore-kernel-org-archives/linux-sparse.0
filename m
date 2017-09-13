From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Handling of local variables in the backend
Date: Wed, 13 Sep 2017 10:56:16 +0100
Message-ID: <CACXZuxcapzEcNs6v00TCRWxzETsGoMAD1hLk9YJEJw+5HBdBTg@mail.gmail.com>
References: <CACXZuxd2XOKBaTnPEGEy-XZPTg_PJrA_XnNUfbbHm2X7zxKcmA@mail.gmail.com>
 <CANeU7QmiSJ2NFykLn__EaeCK03d4zzGBttFa=Skcn487C-RdjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f175.google.com ([209.85.217.175]:37629 "EHLO
        mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751054AbdIMJ4R (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 13 Sep 2017 05:56:17 -0400
Received: by mail-ua0-f175.google.com with SMTP id k23so18067134uaf.4
        for <linux-sparse@vger.kernel.org>; Wed, 13 Sep 2017 02:56:16 -0700 (PDT)
In-Reply-To: <CANeU7QmiSJ2NFykLn__EaeCK03d4zzGBttFa=Skcn487C-RdjQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Chris,

On 12 September 2017 at 23:44, Christopher Li <sparse@chrisli.org> wrote:
> On Tue, Sep 12, 2017 at 5:54 PM, Dibyendu Majumdar
> <mobile@majumdar.org.uk> wrote:
>>
>> I think that there is no easy way to identify all the symbols used for
>> which stack space is needed and do the allocas at the start - is
>> there? I mean the only way is to go through all the instructions to
>> find these references as far as I know.
>
>
> Have you try the sym->symbol_list for the function node?
> It should contain all the symbol used in that function.
>

Did you mean struct entrypoint -> syms instead?
I see that this contains a list of symbols ... I don't know if this is
guaranteed to have all symbols defined in the function.

Regards
Dibyendu
