From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v0 1/4] be more careful with concat_user_list()
Date: Thu, 27 Apr 2017 18:41:54 -0400
Message-ID: <CANeU7Q=vHmFJ5uWVBNUbkzSw+YL314ynsjQCi9CP-uFTi+GqAw@mail.gmail.com>
References: <20170311154725.87906-1-luc.vanoostenryck@gmail.com> <20170311154725.87906-2-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:35816 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753240AbdD0Wlz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 27 Apr 2017 18:41:55 -0400
Received: by mail-io0-f172.google.com with SMTP id r16so39030750ioi.2
        for <linux-sparse@vger.kernel.org>; Thu, 27 Apr 2017 15:41:55 -0700 (PDT)
In-Reply-To: <20170311154725.87906-2-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>

On Sat, Mar 11, 2017 at 10:47 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> In convert_instruction_target(), once all users have been converted
> the old user list is concatened to the one of the replacing pseudo.
> But this pseudo may be one for which a user list is meaningless,
> like PSEUDO_VAL.
>
> While as such it's not a problem, it inhibit the reuse of the users
> pointer for other uses.


Looks good to me.

Chris
