From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 1/5] do not corrupt ptrlist while killing unreachable BBs
Date: Fri, 7 Jul 2017 08:04:14 +0200
Message-ID: <20170707060413.jmnflgn6kutugozb@ltop.local>
References: <20170706191950.81268-1-luc.vanoostenryck@gmail.com>
 <20170706191950.81268-2-luc.vanoostenryck@gmail.com>
 <CANeU7QnbwqVcZdbarrj4OdpR9-TaG9=t5Q_CDFZXSuB+SN8zLw@mail.gmail.com>
 <CANeU7QnVNE38ODJ+cgUzD3Vz4XKogk-RL2v6-dS2aX9Oc4_0uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:35428 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750844AbdGGGER (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 7 Jul 2017 02:04:17 -0400
Received: by mail-wr0-f175.google.com with SMTP id k67so31439195wrc.2
        for <linux-sparse@vger.kernel.org>; Thu, 06 Jul 2017 23:04:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANeU7QnVNE38ODJ+cgUzD3Vz4XKogk-RL2v6-dS2aX9Oc4_0uQ@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On Thu, Jul 06, 2017 at 06:18:48PM -0700, Christopher Li wrote:
> On Thu, Jul 6, 2017 at 5:40 PM, Christopher Li <sparse@chrisli.org> wrote:
> Most noticablely remove_usage() inside of the  kill_use_list()
> loop.

Can you explain a bit what's wrong with this one?

The call chain looks basically like:
   simplify_instruction()			loop over ep->bb & bb->insns)
      kill_use_list()				loop over insn->phi_list
         kill_use() -> remove_use()
            delete_pseudo_user_list_entry	loop over pseudo->users
            kill_instruction()
               kill_use_list()


Note: kill_instruction() doesn't delete the instruction from
      the BB but just mark them as removed which is, I think,
      the right pattern to adopt in general instead of the
      delete/pack.

-- Luc
