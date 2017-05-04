From: Christopher Li <sparse@chrisli.org>
Subject: Re: bit-field notation and k&r function syntax
Date: Wed, 3 May 2017 21:50:14 -0400
Message-ID: <CANeU7Qn+R5auoxi=-==W+uExRfE7wRc7pfK-5OcENVEaB1-9Hw@mail.gmail.com>
References: <1231012108.4484627.1493830970281.JavaMail.zimbra@redhat.com>
 <571546431.4485670.1493831412428.JavaMail.zimbra@redhat.com> <20170503230721.vb4aunmpaa2xxaf2@desk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:36000 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932183AbdEDBuP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 3 May 2017 21:50:15 -0400
Received: by mail-io0-f182.google.com with SMTP id p80so2682148iop.3
        for <linux-sparse@vger.kernel.org>; Wed, 03 May 2017 18:50:14 -0700 (PDT)
In-Reply-To: <20170503230721.vb4aunmpaa2xxaf2@desk.local>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Lance Richardson <lrichard@redhat.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, May 3, 2017 at 7:07 PM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> What's sparse use 'declaration_list()' for is not what correspond
> to the standard's 'declaration-list' but is indeed for something
> that should be reserved to structs.

I think declaration_list() can add one argument "is_struct" to
indicate parse for struct or not.
Only in struct mode we do the ":" and handle_bitfield() thing.
There are only two caller of declaration_list() so that should fix it.

Chris
