From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCH 9/9 v2] check inlines explicitly
Date: Thu, 29 May 2008 16:20:42 -0700
Message-ID: <1212103242.28403.158.camel@brick>
References: <20080529085402.814224000@sipsolutions.net>
	 <20080529085519.078206000@sipsolutions.net>
	 (sfid-20080529_110105_170182_8D02CA8F)  <1212102852.10109.15.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.233]:14200 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754288AbYE2XUp (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 29 May 2008 19:20:45 -0400
Received: by wr-out-0506.google.com with SMTP id c48so3205983wra.1
        for <linux-sparse@vger.kernel.org>; Thu, 29 May 2008 16:20:44 -0700 (PDT)
In-Reply-To: <1212102852.10109.15.camel@johannes.berg>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Josh Triplett <josh@freedesktop.org>, Philipp Reisner <philipp.reisner@linbit.com>, linux-sparse@vger.kernel.org, Pavel Roskin <proski@gnu.org>

On Fri, 2008-05-30 at 01:14 +0200, Johannes Berg wrote:
> An earlier patch disabled checking through inline functions because
> inlining them clashes with the context tracking code, so this now
> makes sparse check the inline functions as though they were really
> functions.
> 
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

Works for me.

Harvey

