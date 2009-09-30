From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Ignore the alloc_size attribute.
Date: Wed, 30 Sep 2009 14:02:50 -0700
Message-ID: <70318cbf0909301402r37b56fc3q790107f48456f4b5@mail.gmail.com>
References: <20090930201930.GB32461@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f192.google.com ([209.85.212.192]:44409 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754156AbZI3VCq (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 30 Sep 2009 17:02:46 -0400
Received: by vws30 with SMTP id 30so4415295vws.21
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2009 14:02:50 -0700 (PDT)
In-Reply-To: <20090930201930.GB32461@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Michael Stefaniuc <mstefaniuc@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Wed, Sep 30, 2009 at 1:19 PM, Michael Stefaniuc <mstefaniuc@gmail.com> wrote:
> Wine has annotated the Win32 alloc functions with the alloc_size
> attribute. This cuts down the noise a lot when running sparse on the
> Wine source code.

Both patches were applied and pushed.

Thanks

Chris
