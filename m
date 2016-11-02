From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 2/2] validation: Check C99 for loop variables
Date: Wed, 2 Nov 2016 15:04:20 +0100
Message-ID: <20161102140419.GB9029@macpro.local>
References: <1462365584-20536-1-git-send-email-emily@emilymaier.net>
 <1462365584-20536-2-git-send-email-emily@emilymaier.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35368 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753021AbcKBOEY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 2 Nov 2016 10:04:24 -0400
Received: by mail-wm0-f67.google.com with SMTP id 68so3241614wmz.2
        for <linux-sparse@vger.kernel.org>; Wed, 02 Nov 2016 07:04:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1462365584-20536-2-git-send-email-emily@emilymaier.net>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Emily Maier <emily@emilymaier.net>
Cc: linux-sparse@vger.kernel.org

On Wed, May 04, 2016 at 08:39:44AM -0400, Emily Maier wrote:
> Previously, sparse would generate incorrect code in the presence of a
> C99 variable declaration inside the for statement, completely dropping
> the code after the end of the for loop. Check that it's now behaving
> correctly by entering a context and not leaving it at the end of the
> loop.
> 
> Signed-off-by: Emily Maier <emily@emilymaier.net>
> ---

I think a simpler test case showing the generality of the problem
would be even nicer but that would involve the output of
test-linearize and as such this is not usable in the test suite.

This test case has the decisive advantage to be testable.

Revieved-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
