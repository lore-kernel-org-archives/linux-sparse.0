From: foobar <foobar@redchan.it>
Subject: Re: [PATCH 1/2] give a type to builtin functions
Date: Wed, 3 Jan 2018 15:57:43 +0000
Message-ID: <20180103155743.240cb67f567d3fb4ae970ef7@redchan.it>
References: <20180101225817.3cb135dc04ea0195f28d8512@redchan.it>
        <20180102151116.22060-1-luc.vanoostenryck@gmail.com>
        <20180102151116.22060-2-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from cock.li ([185.100.85.212]:36613 "EHLO cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751856AbeACP6S (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 3 Jan 2018 10:58:18 -0500
In-Reply-To: <20180102151116.22060-2-luc.vanoostenryck@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Tue,  2 Jan 2018 16:11:15 +0100
Luc Van Oostenryck <luc.vanoostenryck@gmail.com> wrote:

> When creating builtin functions via init-builtins(), it shouldn't
> really be needed to give them a type because their purpose is only
> as a placeholder for the symbol->op->{evaluate,expand,..}. Also,
> they should be part of the builtin_scope and never be visible.

yeah, it seems odd (and annoying at the same time) that ctags emits internal symbols __builtin_bswap16 and similar stuff, unlike exuberant ctags.
