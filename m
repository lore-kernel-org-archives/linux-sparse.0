From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 2/5] Add support for the MinGW platform
Date: Wed, 22 May 2013 17:46:53 -0700
Message-ID: <20130523004653.GB12285@jtriplet-mobl1>
References: <519BC816.3000304@ramsay1.demon.co.uk>
 <20130521220907.GE11463@jtriplet-mobl1>
 <519D419F.8090000@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:41760 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754052Ab3EWArD (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 22 May 2013 20:47:03 -0400
Content-Disposition: inline
In-Reply-To: <519D419F.8090000@ramsay1.demon.co.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Cc: Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

On Wed, May 22, 2013 at 11:07:27PM +0100, Ramsay Jones wrote:
> Josh Triplett wrote:
> > On Tue, May 21, 2013 at 08:16:38PM +0100, Ramsay Jones wrote:
> >> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> > 
> > I believe this will match both 32-bit and 64-bit MinGW, which seems
> > wrong.  Please do check the architecture strings for 32-bit and 64-bit
> > MinGW, and handle them separately.
> 
> Yes, given that, for me:
> 
>   $ uname -a
>   MINGW32_NT-5.1 TOSHIBA 1.0.12(0.46/3/2) 2010-02-05 01:08 i686 unknown
>   $
> 
> I'm hoping that the following change will be sufficient (I don't have
> access to a 64-bit MinGW, so I don't know what 'uname -a' returns, but
> I think this will work ... ;-):
> 
>   $ git diff
>   diff --git a/cgcc b/cgcc
>   index e94a965..68f96b9 100755
>   --- a/cgcc
>   +++ b/cgcc
>   @@ -226,7 +226,7 @@ sub add_specs {
>               ' -D__OpenBSD__=1';
>        } elsif ($spec eq 'unix') {
>           return ' -Dunix=1 -D__unix=1 -D__unix__=1';
>   -    } elsif ($spec =~ /^mingw/) {
>   +    } elsif ($spec =~ /^mingw32/) {

Unfortunately, I don't think that suffices; I've seen a few different
architecture triples used for 64-bit MinGW, some of which include
"mingw32".  I *think* it might work to match i[3-6]86-.*-mingw.

- Josh Triplett
