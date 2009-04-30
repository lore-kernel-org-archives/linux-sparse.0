From: Christopher Li <sparse@chrisli.org>
Subject: Re: `char * s = "abc";' causes compile to crash with a segfault
Date: Thu, 30 Apr 2009 02:16:49 -0700
Message-ID: <70318cbf0904300216s46f5698bydac39606354f080e@mail.gmail.com>
References: <op.us51m0w9ucb9g9@home-5db3af48a> <49F8C1EB.5010909@garzik.org>
	 <op.us6y25squcb9g9@home-5db3af48a>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:54650 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbZD3JQv (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 30 Apr 2009 05:16:51 -0400
Received: by yx-out-2324.google.com with SMTP id 3so985246yxj.1
        for <linux-sparse@vger.kernel.org>; Thu, 30 Apr 2009 02:16:50 -0700 (PDT)
In-Reply-To: <op.us6y25squcb9g9@home-5db3af48a>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Alexander Sorockin <sorockin@yandex.ru>
Cc: linux-sparse@vger.kernel.org

On Thu, Apr 30, 2009 at 1:55 AM, Alexander Sorockin <sorockin@yandex.ru> wrote:
> Hmm. It's interesting that sparse itself doesn't seem to compile with
> anything other that gcc. Does that mean that most other compilers are
> "non-standard"?

Sparse use some C99 feature. Those "non-standard" compiler without C99
support can't compiling it. I don't think sparse has much gcc specific
stuff though.

Chris
