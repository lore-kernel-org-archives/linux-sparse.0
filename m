Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96852C433EF
	for <linux-sparse@archiver.kernel.org>; Tue, 14 Dec 2021 15:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbhLNPRB (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 14 Dec 2021 10:17:01 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:34324 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235308AbhLNPQ7 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 14 Dec 2021 10:16:59 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id AC75F72C8DC;
        Tue, 14 Dec 2021 18:16:56 +0300 (MSK)
Received: from example.org (ip-78-45-37-102.net.upcbroadband.cz [78.45.37.102])
        by imap.altlinux.org (Postfix) with ESMTPSA id 326714A46EA;
        Tue, 14 Dec 2021 18:16:56 +0300 (MSK)
Date:   Tue, 14 Dec 2021 16:16:55 +0100
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-sparse@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 0/3] semind: Index more symbols
Message-ID: <20211214151655.o6hank75ylvmr5un@example.org>
References: <20211102140645.83081-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102140645.83081-1-gladkov.alexey@gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Tue, Nov 02, 2021 at 03:06:42PM +0100, Alexey Gladkov wrote:
> Greetings!
> 
> For indexing purposes, macros definitions and typedefs are added to the
> semind database. Functions that are not used in the code are also indexed.

careful ping.

> Alexey Gladkov (3):
>   dissect: Allow to show all symbols
>   dissect: Show macro definitions
>   dissect: Show typedefs
> 
>  dissect.c      | 61 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  options.c      |  5 +++++
>  options.h      |  2 ++
>  semind.c       |  1 +
>  test-dissect.c |  5 ++++-
>  5 files changed, 72 insertions(+), 2 deletions(-)
> 
> -- 
> 2.33.0
> 

-- 
Rgrds, legion

