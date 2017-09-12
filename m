From: Christopher Li <sparse@chrisli.org>
Subject: Re: Handling of local variables in the backend
Date: Tue, 12 Sep 2017 18:44:19 -0400
Message-ID: <CANeU7QmiSJ2NFykLn__EaeCK03d4zzGBttFa=Skcn487C-RdjQ@mail.gmail.com>
References: <CACXZuxd2XOKBaTnPEGEy-XZPTg_PJrA_XnNUfbbHm2X7zxKcmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f178.google.com ([209.85.161.178]:36695 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750988AbdILWoV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 12 Sep 2017 18:44:21 -0400
Received: by mail-yw0-f178.google.com with SMTP id v72so29243959ywa.3
        for <linux-sparse@vger.kernel.org>; Tue, 12 Sep 2017 15:44:20 -0700 (PDT)
In-Reply-To: <CACXZuxd2XOKBaTnPEGEy-XZPTg_PJrA_XnNUfbbHm2X7zxKcmA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Tue, Sep 12, 2017 at 5:54 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:
>
> I think that there is no easy way to identify all the symbols used for
> which stack space is needed and do the allocas at the start - is
> there? I mean the only way is to go through all the instructions to
> find these references as far as I know.


Have you try the sym->symbol_list for the function node?
It should contain all the symbol used in that function.

I can even see that symbol_list under test-inspect.
under
[SYM_NODE:
       [ ctype.base_type: SYM_FN]
       [ symbol_list: symbol_list,
            ... <============== here.
       ]
]

It has other label symbol as well. You should be able to filter
out those pretty easily.

Chris
