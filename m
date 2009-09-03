From: Christopher Li <sparse@chrisli.org>
Subject: Re: sparse: flow.c:804: rewrite_parent_branch: Asparse: flow.c:804:
	rewrite_parent_branch: Assertion `changed' failed.
Date: Thu, 3 Sep 2009 11:42:04 -0700
Message-ID: <70318cbf0909031142x7ba0963fr5524580204fec61e@mail.gmail.com>
References: <e7c6a05e0909030249qb5dac77u35293c4d857bba0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vw0-f195.google.com ([209.85.212.195]:38657 "EHLO
	mail-vw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755997AbZICSmC (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 3 Sep 2009 14:42:02 -0400
Received: by vws33 with SMTP id 33so173939vws.33
        for <linux-sparse@vger.kernel.org>; Thu, 03 Sep 2009 11:42:04 -0700 (PDT)
In-Reply-To: <e7c6a05e0909030249qb5dac77u35293c4d857bba0f@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Thu, Sep 3, 2009 at 2:49 AM, Belisko Marek<marek.belisko@gmail.com> wrote:
> Hi,
>
> current linux-next tree compiled with make C=1 all >build.out 2>&1
> produce following error.

I am wondering which sparse you are using. Does this happen with the
current sparse git tree or the sparse come with distributions?

Chris
