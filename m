From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Fix type_info_expression()
Date: Thu, 5 Feb 2009 12:21:24 -0800
Message-ID: <70318cbf0902051221y7ec61944m3880bf52fbbbbb1a@mail.gmail.com>
References: <20090202073151.GC28946@ZenIV.linux.org.uk>
	 <70318cbf0902051029n11975b41l38f17a635dcf5fbd@mail.gmail.com>
	 <20090205192322.GN28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:25083 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755011AbZBEUVZ (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 5 Feb 2009 15:21:25 -0500
Received: by rv-out-0506.google.com with SMTP id g9so2626956rvb.5
        for <linux-sparse@vger.kernel.org>; Thu, 05 Feb 2009 12:21:24 -0800 (PST)
In-Reply-To: <20090205192322.GN28946@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-sparse@vger.kernel.org

On Thu, Feb 5, 2009 at 11:23 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Thu, Feb 05, 2009 at 10:29:19AM -0800, Christopher Li wrote:

> Take a look at evaluate_type_information().  If ->cast_type is not NULL,
> it won't even look at ->cast_expression.  For sizeof (struct foo){0,1} that's
> fine (you end with with sizeof(struct foo), essentially), but for
> sizeof(struct foo){0,1}.x that'll give you the wrong answer.
>
> IOW, it is necessary.

That is the subtle detail I am looking for.

I will apply your patch.

Thanks

Chris
