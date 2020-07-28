Return-Path: <SRS0=zxAK=BH=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFBAC433E8
	for <linux-sparse@archiver.kernel.org>; Tue, 28 Jul 2020 19:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9296C20809
	for <linux-sparse@archiver.kernel.org>; Tue, 28 Jul 2020 19:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KemNEhbQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbgG1Ttq (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 28 Jul 2020 15:49:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30529 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728202AbgG1Ttq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Jul 2020 15:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595965785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qDV12T7Ado1RCVWHf40xHrPqzzarWKrC7bDsbJ8XUxk=;
        b=KemNEhbQe2iI8bl5yZtl/9dcQ1bGt7ryBB3HP32nBowIgiEqdTMt6ZBzbuxHiRdMNSNyNw
        kKy+dTx8xLS+MNhpVVtlhPyeKbpW4XjgfpmCXHRD8WpUT46O47vSWLLzeevQy5Qjmiws3Y
        dXGaIbbxLNayQCfmBuFj4a1bqmpGIIc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-_wVyrfmWOMKNJegQaBdeQA-1; Tue, 28 Jul 2020 15:49:41 -0400
X-MC-Unique: _wVyrfmWOMKNJegQaBdeQA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 755F41DE5;
        Tue, 28 Jul 2020 19:49:40 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.69])
        by smtp.corp.redhat.com (Postfix) with SMTP id 69F08712FA;
        Tue, 28 Jul 2020 19:49:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 28 Jul 2020 21:49:40 +0200 (CEST)
Date:   Tue, 28 Jul 2020 21:49:38 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     linux-sparse@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH] dissect: add support for _Generic
Message-ID: <20200728194937.GA2467@redhat.com>
References: <20200728183507.422662-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200728183507.422662-1-gladkov.alexey@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On 07/28, Alexey Gladkov wrote:
>
> No special support needed for _Generic,

Hmm. I am already sleeping and didn't read the _Generic code yet... but
shouldn't dissect() inspect ->control/map/def?

That said,

> so just suppress the warning
> about unknown type.

probably better than nothing, lets shut up the warning first.

Oleg.

