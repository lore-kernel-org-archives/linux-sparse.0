From: Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] recognize binary constants
Date: Thu, 8 Sep 2011 11:11:30 -0700
Message-ID: <20110908181130.GC17041@mwanda>
References: <1315434714.1892.7.camel@marconi>
 <20110908170734.GB17041@mwanda>
 <1315504050.2011.16.camel@marconi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:52977 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755071Ab1IHX5D (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Thu, 8 Sep 2011 19:57:03 -0400
Content-Disposition: inline
In-Reply-To: <1315504050.2011.16.camel@marconi>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamal Mostafa <kamal@canonical.com>
Cc: linux-sparse@vger.kernel.org, smatch@vger.kernel.org

On Thu, Sep 08, 2011 at 10:47:30AM -0700, Kamal Mostafa wrote:
> A small change to your patch, Dan:  I added a call to tolower(), since
> "0B11" is also a valid syntax.
> 

Doh...  Good point.  Thanks.

regards,
dan carpenter

