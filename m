From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Add a define for __builtin_ms_va_copy()
Date: Fri, 13 Mar 2015 10:51:23 -0700
Message-ID: <CANeU7Q=PxbRsFa_WSuA_uLDUCr=VevvCmdREhVmj1fZxVpdxOw@mail.gmail.com>
References: <20150311232214.GB14617@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:47026 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932197AbbCMRvX (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 13 Mar 2015 13:51:23 -0400
Received: by qcyl6 with SMTP id l6so28440572qcy.13
        for <linux-sparse@vger.kernel.org>; Fri, 13 Mar 2015 10:51:23 -0700 (PDT)
In-Reply-To: <20150311232214.GB14617@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Michael Stefaniuc <mstefani@redhat.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Wed, Mar 11, 2015 at 4:22 PM, Michael Stefaniuc <mstefani@redhat.com> wrote:
> Signed-off-by: Michael Stefaniuc <mstefani@redhat.com>
> ---
> Gets rid of the remaining "error: undefined identifier '__builtin_...'"
> in Wine.


Both patch applied and pushed.

Can you submit some test case while you are there?

Thanks

Chris
