From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: Feature request - suppress warnings for system libraries
Date: Sat, 3 Feb 2007 00:40:01 +0000
Message-ID: <20070203004001.GH10050@ftp.linux.org.uk>
References: <1170438183.2272.29.camel@dv> <20070202220148.GB27667@chrisli.org> <1170455865.4698.8.camel@dv> <20070202223155.GD27667@chrisli.org> <20070202231705.GF10050@ftp.linux.org.uk> <Pine.LNX.4.64.0702021522480.15057@woody.linux-foundation.org> <20070203003030.GG10050@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:58942 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946186AbXBCAkE (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 2 Feb 2007 19:40:04 -0500
Content-Disposition: inline
In-Reply-To: <20070203003030.GG10050@ftp.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christopher Li <sparse@chrisli.org>, Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

On Sat, Feb 03, 2007 at 12:30:30AM +0000, Al Viro wrote:
> There probably is some legitimate set of checks the authors wanted, but
> __bitwise__ sure as hell is not it...

... and even weirder:

typedef int __bitwise snd_pcm_format_t;
#define SNDRV_PCM_FORMAT_S8     ((__force snd_pcm_format_t) 0)
#define SNDRV_PCM_FORMAT_U8     ((__force snd_pcm_format_t) 1)
#define SNDRV_PCM_FORMAT_S16_LE ((__force snd_pcm_format_t) 2)
#define SNDRV_PCM_FORMAT_S16_BE ((__force snd_pcm_format_t) 3)
#define SNDRV_PCM_FORMAT_U16_LE ((__force snd_pcm_format_t) 4)
#define SNDRV_PCM_FORMAT_U16_BE ((__force snd_pcm_format_t) 5)
....
#define SNDRV_PCM_FMTBIT_S8             (1ULL << SNDRV_PCM_FORMAT_S8)
#define SNDRV_PCM_FMTBIT_U8             (1ULL << SNDRV_PCM_FORMAT_U8)
#define SNDRV_PCM_FMTBIT_S16_LE         (1ULL << SNDRV_PCM_FORMAT_S16_LE)
#define SNDRV_PCM_FMTBIT_S16_BE         (1ULL << SNDRV_PCM_FORMAT_S16_BE)
#define SNDRV_PCM_FMTBIT_U16_LE         (1ULL << SNDRV_PCM_FORMAT_U16_LE)
#define SNDRV_PCM_FMTBIT_U16_BE         (1ULL << SNDRV_PCM_FORMAT_U16_BE)
