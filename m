From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Support the __thread storage class
Date: Tue, 19 May 2009 03:00:40 -0700
Message-ID: <70318cbf0905190300o1b82f2aax433b08248ac08c3a@mail.gmail.com>
References: <70318cbf0904270020v78c98b7awee9ef64a6d60e14b@mail.gmail.com>
	 <1242488218-19811-1-git-send-email-albertito@blitiri.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.30]:48277 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753366AbZESKAj (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 19 May 2009 06:00:39 -0400
Received: by yx-out-2324.google.com with SMTP id 3so2335118yxj.1
        for <linux-sparse@vger.kernel.org>; Tue, 19 May 2009 03:00:40 -0700 (PDT)
In-Reply-To: <1242488218-19811-1-git-send-email-albertito@blitiri.com.ar>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alberto Bertogli <albertito@blitiri.com.ar>
Cc: linux-sparse@vger.kernel.org, josh@kernel.org

On Sat, May 16, 2009 at 8:36 AM, Alberto Bertogli
<albertito@blitiri.com.ar> wrote:
> GCC supports a __thread storage class, used to indicate thread-local
> storage. It may be used alone, or with extern or static.
>

Thanks, I applied it to my tree already.

Chris
