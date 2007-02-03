From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: Feature request - suppress warnings for system libraries
Date: Sat, 3 Feb 2007 00:30:30 +0000
Message-ID: <20070203003030.GG10050@ftp.linux.org.uk>
References: <1170438183.2272.29.camel@dv> <20070202220148.GB27667@chrisli.org> <1170455865.4698.8.camel@dv> <20070202223155.GD27667@chrisli.org> <20070202231705.GF10050@ftp.linux.org.uk> <Pine.LNX.4.64.0702021522480.15057@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:37290 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933400AbXBCAai (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 2 Feb 2007 19:30:38 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702021522480.15057@woody.linux-foundation.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christopher Li <sparse@chrisli.org>, Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

On Fri, Feb 02, 2007 at 03:25:20PM -0800, Linus Torvalds wrote:
> > Unlike __transparent_union__, restrict is at least a valid C...  It's not
> > that hard to handle, except for the shortage of bits for modifiers...
> 
> At worst, we could parse and ignore it.

*nod*

BTW, speaking of atrocities...

include/sound/asound.h:
typedef int __bitwise snd_pcm_hw_param_t;
#define SNDRV_PCM_HW_PARAM_ACCESS       ((__force snd_pcm_hw_param_t) 0) /* Access type */
#define SNDRV_PCM_HW_PARAM_FORMAT       ((__force snd_pcm_hw_param_t) 1) /* Format */
#define SNDRV_PCM_HW_PARAM_SUBFORMAT    ((__force snd_pcm_hw_param_t) 2) /* Subformat */
#define SNDRV_PCM_HW_PARAM_FIRST_MASK   SNDRV_PCM_HW_PARAM_ACCESS
#define SNDRV_PCM_HW_PARAM_LAST_MASK    SNDRV_PCM_HW_PARAM_SUBFORMAT

....

struct snd_pcm_hw_params {
        unsigned int flags;
        struct snd_mask masks[SNDRV_PCM_HW_PARAM_LAST_MASK -
                               SNDRV_PCM_HW_PARAM_FIRST_MASK + 1];


WTF is going on here?  We obviously do *not* treat that as bitwise.
Not only a blatant subtraction in the above; we do add that sucker to
pointer when accessing array elements.  Moreover, just look at the
other values:
#define SNDRV_PCM_HW_PARAM_SAMPLE_BITS  ((__force snd_pcm_hw_param_t) 8) /* Bits per sample */
#define SNDRV_PCM_HW_PARAM_FRAME_BITS   ((__force snd_pcm_hw_param_t) 9) /* Bits per frame */
#define SNDRV_PCM_HW_PARAM_CHANNELS     ((__force snd_pcm_hw_param_t) 10) /* Channels */
#define SNDRV_PCM_HW_PARAM_RATE         ((__force snd_pcm_hw_param_t) 11) /* Approx rate */  
#define SNDRV_PCM_HW_PARAM_PERIOD_TIME  ((__force snd_pcm_hw_param_t) 12) /* Approx distance between interrupts in us */
etc.

It's certainly not a bitwise type.  I'm not sure what the hell it's really
meant to be...   We have a similar turd in pm.h:
typedef int __bitwise suspend_state_t;

#define PM_SUSPEND_ON           ((__force suspend_state_t) 0)
#define PM_SUSPEND_STANDBY      ((__force suspend_state_t) 1)
#define PM_SUSPEND_MEM          ((__force suspend_state_t) 3)
#define PM_SUSPEND_DISK         ((__force suspend_state_t) 4)
#define PM_SUSPEND_MAX          ((__force suspend_state_t) 5)

with things like
./kernel/power/main.c:274:      for (s = &pm_states[state]; state < PM_SUSPEND_MAX; s++, state++) {

using it.  Again, we have uses of that sucker as array size, for ordered
comparisons, for adding to pointer and for adding integer to it.  And
|, &, ^ and ~ are very definitely _not_ wanted on these values.

There probably is some legitimate set of checks the authors wanted, but
__bitwise__ sure as hell is not it...
