From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 2/5] Add support for the MinGW platform
Date: Wed, 22 May 2013 23:07:27 +0100
Message-ID: <519D419F.8090000@ramsay1.demon.co.uk>
References: <519BC816.3000304@ramsay1.demon.co.uk> <20130521220907.GE11463@jtriplet-mobl1>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:55758 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757583Ab3EVWOT (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 22 May 2013 18:14:19 -0400
In-Reply-To: <20130521220907.GE11463@jtriplet-mobl1>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Christopher Li <sparse@chrisli.org>, Sparse Mailing-list <linux-sparse@vger.kernel.org>

Josh Triplett wrote:
> On Tue, May 21, 2013 at 08:16:38PM +0100, Ramsay Jones wrote:
>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> 
> I believe this will match both 32-bit and 64-bit MinGW, which seems
> wrong.  Please do check the architecture strings for 32-bit and 64-bit
> MinGW, and handle them separately.

Yes, given that, for me:

  $ uname -a
  MINGW32_NT-5.1 TOSHIBA 1.0.12(0.46/3/2) 2010-02-05 01:08 i686 unknown
  $

I'm hoping that the following change will be sufficient (I don't have
access to a 64-bit MinGW, so I don't know what 'uname -a' returns, but
I think this will work ... ;-):

  $ git diff
  diff --git a/cgcc b/cgcc
  index e94a965..68f96b9 100755
  --- a/cgcc
  +++ b/cgcc
  @@ -226,7 +226,7 @@ sub add_specs {
              ' -D__OpenBSD__=1';
       } elsif ($spec eq 'unix') {
          return ' -Dunix=1 -D__unix=1 -D__unix__=1';
  -    } elsif ($spec =~ /^mingw/) {
  +    } elsif ($spec =~ /^mingw32/) {
          return ' -isystem /mingw/include' .
              ' -D__MINGW32__=1' .
              ' -D__MSVCRT__=1' .
  $


ATB,
Ramsay Jones


