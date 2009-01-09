From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: source code transform
Date: Thu, 08 Jan 2009 16:38:56 -0800
Message-ID: <1231461536.5715.31.camel@brick>
References: <a15fe1ffe7f7a6faf8f79d4ac780b663@mail.smartmobili.com>
	 <1231354996.3545.80.camel@johannes>  <87skntqs5e.fsf@aryx.cs.uiuc.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:11903 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759734AbZAIAi6 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 8 Jan 2009 19:38:58 -0500
Received: by wf-out-1314.google.com with SMTP id 27so9555013wfd.4
        for <linux-sparse@vger.kernel.org>; Thu, 08 Jan 2009 16:38:57 -0800 (PST)
In-Reply-To: <87skntqs5e.fsf@aryx.cs.uiuc.edu>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Yoann Padioleau <padator@wanadoo.fr>
Cc: Johannes Berg <johannes@sipsolutions.net>, mosfet <forumer@smartmobili.com>, linux-sparse@vger.kernel.org, Julia Lawall <julia@diku.dk>

On Thu, 2009-01-08 at 17:45 -0600, Yoann Padioleau wrote:
> Johannes Berg <johannes@sipsolutions.net> writes:

> @@
> identifier f;
> @@
> 
>  f(...)
>  { 
> + fprintf(stderr, "%s: %s()\n", __FILE__, __FUNCTION__);
>  ...
>  }
> 

Personal pet-peeve, use __func__, not __FUNCTION__.

__func__ is C, __FUNCTION__ is a gcc-extension.

Cheers,

Harvey

