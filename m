From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Handling of local variables in the backend
Date: Wed, 13 Sep 2017 11:22:24 +0100
Message-ID: <CACXZuxfw51dA6Ye2wzHTw2FNVKvP1pnq0WiKZH+5E_8j1viJOw@mail.gmail.com>
References: <CACXZuxd2XOKBaTnPEGEy-XZPTg_PJrA_XnNUfbbHm2X7zxKcmA@mail.gmail.com>
 <CANeU7QmiSJ2NFykLn__EaeCK03d4zzGBttFa=Skcn487C-RdjQ@mail.gmail.com>
 <CACXZuxcapzEcNs6v00TCRWxzETsGoMAD1hLk9YJEJw+5HBdBTg@mail.gmail.com> <20170913101842.ax5eiyoe5dgliibe@ltop.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f169.google.com ([209.85.217.169]:36268 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751678AbdIMKWZ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 13 Sep 2017 06:22:25 -0400
Received: by mail-ua0-f169.google.com with SMTP id q29so18188634uaf.3
        for <linux-sparse@vger.kernel.org>; Wed, 13 Sep 2017 03:22:25 -0700 (PDT)
In-Reply-To: <20170913101842.ax5eiyoe5dgliibe@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Linux-Sparse <linux-sparse@vger.kernel.org>

Hi Luc,

On 13 September 2017 at 11:18, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> On Wed, Sep 13, 2017 at 10:56:16AM +0100, Dibyendu Majumdar wrote:
>> Hi Chris,
>>
>> On 12 September 2017 at 23:44, Christopher Li <sparse@chrisli.org> wrote:
>> > On Tue, Sep 12, 2017 at 5:54 PM, Dibyendu Majumdar
>> > <mobile@majumdar.org.uk> wrote:
>> >>
>> >> I think that there is no easy way to identify all the symbols used for
>> >> which stack space is needed and do the allocas at the start - is
>> >> there? I mean the only way is to go through all the instructions to
>> >> find these references as far as I know.
>> >
>> >
>> > Have you try the sym->symbol_list for the function node?
>> > It should contain all the symbol used in that function.
>> >
>>
>> Did you mean struct entrypoint -> syms instead?
>> I see that this contains a list of symbols ... I don't know if this is
>> guaranteed to have all symbols defined in the function.
>
> ep->accesses contains all the pseudos corresponding to the symbols
> used for doing load & store accesses.
>
> So, you probably should doing something like:
>
>         pseudo_t pseudo;
>
>         FOR_EACH_PTR(ep->accesses, pseudo) {
>                 struct symbol *sym = pseudo->sym;
>                 unsigned log mods = sym->ctype.modifiers;
>
>                 if (mods & MOD_VOLATILE)
>                         ...
>                 if (mods & (MOD_NONLOCAL | MOD_STATIC | MOD_ADDRESSABLE))
>                         ...
>
>

Thanks. I will look at this.

Regards
Dibyendu
