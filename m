From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] Makefile: remove SMATCH_DATA
 smatch_data/kernel.balanced_funcs item
Date: Wed, 17 May 2017 12:28:08 +0300
Message-ID: <20170517092808.xwxofmiywj46un2q@mwanda>
References: <20170516174308.27102-1-kerolasa@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:20827 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754190AbdEQJ2b (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 17 May 2017 05:28:31 -0400
Content-Disposition: inline
In-Reply-To: <20170516174308.27102-1-kerolasa@iki.fi>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Sami Kerola <kerolasa@iki.fi>
Cc: linux-sparse@vger.kernel.org

On Tue, May 16, 2017 at 06:43:08PM +0100, Sami Kerola wrote:
> File was removed recently.  Removal commit missed Makefile clean up.
> 

EEep...  Thanks.  I'll push this in a few hours.

I need to update my build scripts to do a install.  There isn't a
`make uninstall` target.  How are you cleaning up?

regards,
dan carpenter

