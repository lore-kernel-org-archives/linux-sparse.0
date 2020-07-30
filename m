Return-Path: <SRS0=kwZw=BJ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9005BC433E0
	for <linux-sparse@archiver.kernel.org>; Thu, 30 Jul 2020 15:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6006620829
	for <linux-sparse@archiver.kernel.org>; Thu, 30 Jul 2020 15:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DTV/2y/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbgG3PWI (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 30 Jul 2020 11:22:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58059 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726353AbgG3PWH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Jul 2020 11:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596122526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ghUk7+F1GzoBBCp2oOUxVnQpspL00uLJe21vC6M/ung=;
        b=DTV/2y/qcbQZxVCHPxw4lvqXlYz/fTuhH0jWZocqaJ8d3iMb454wxFxGtXxuD2Xq5Wvzjf
        ilzRX/T5H7uFyTCLv8kMgqIiAlxJpAtVqoixllwVFokCzpgKIDx6LOzoGooh6juOjLZRAL
        9bo2Ehr6hRRE/uKdL3yVKkBS+H4DTsA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-Ntg1umMFPcClFVZx9ikQTQ-1; Thu, 30 Jul 2020 11:22:04 -0400
X-MC-Unique: Ntg1umMFPcClFVZx9ikQTQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1781C107ACCA;
        Thu, 30 Jul 2020 15:22:03 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.195.189])
        by smtp.corp.redhat.com (Postfix) with SMTP id C9F2B10023A0;
        Thu, 30 Jul 2020 15:22:01 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 30 Jul 2020 17:22:02 +0200 (CEST)
Date:   Thu, 30 Jul 2020 17:22:00 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     linux-sparse@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v1] sindex: allow indexing outside the project tree
Message-ID: <20200730152159.GC6956@redhat.com>
References: <20200730132033.613554-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200730132033.613554-1-gladkov.alexey@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=oleg@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On 07/30, Alexey Gladkov wrote:
>
> One possible way to compile the linux kernel is by using the O=<DIR>
> parameter to place all generated files outside the source tree.
>
> Prior to this patch, sindex filters processed sources to exclude system
> files. The base directory of the project was the current directory.
>
> When compiled outside of the source tree, this may not be the case.
> This patch adds a parameter and an environment variable to specify
> the source tree.
>
> You can use it like this:
>
> $ make O=$PWD-build C=2 CHECK="sindex -B $PWD add --"
>
> This parameter is also needed for searching if you want to display
> the source code line because sindex does not store lines in the database
> but reads them from source files.

Thanks, looks good to me.

Oleg.

