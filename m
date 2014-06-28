From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Staging/comedi: Fixes static analysis warning raised by
 sparse
Date: Sat, 28 Jun 2014 11:07:48 -0700
Message-ID: <CANeU7Qki9Fg=Vz8gryT1bL+BMnjuvWZTH7uNvyk-HjdSPsiiyg@mail.gmail.com>
References: <53965E53.5080504@gmail.com> <20140610054741.GE5500@mwanda>
 <DC148C5AA1CEBA4E87973D432B1C2D8825E9AE6A@P3PWEX4MB008.ex4.secureserver.net>
 <20140611065612.GQ5015@mwanda>
 <DC148C5AA1CEBA4E87973D432B1C2D8825E9CBD6@P3PWEX4MB008.ex4.secureserver.net>
 <20140611212425.GW5015@mwanda> <20140611214529.GB16940@cloud>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20140611214529.GB16940@cloud>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, "Marcos A. Di Pietro" <marcosadp@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-sparse@vger.kernel.org

Sorry for the late reply.

On Wed, Jun 11, 2014 at 2:45 PM,  <josh@joshtriplett.org> wrote:
> On Thu, Jun 12, 2014 at 12:24:25AM +0300, Dan Carpenter wrote:
>> Let's forward this to the Sparse mailing list.
>>
>> We're seeing a Sparse false positive testing

No, this is a valid complain. See my point follows.

>> drivers/staging/comedi/drivers/ni_pcimio.c.
>>
>>   CHECK   drivers/staging/comedi/drivers/ni_pcimio.c
>> drivers/staging/comedi/drivers/ni_stc.h:720:26: warning: shift too big (4294967295) for type int
>> drivers/staging/comedi/drivers/ni_stc.h:720:26: warning: shift too big (4294967295) for type int
>> drivers/staging/comedi/drivers/ni_stc.h:720:26: warning: shift too big (4294967295) for type int
>> drivers/staging/comedi/drivers/ni_stc.h:720:26: warning: shift too big (4294967295) for type int
>>
>> I have created some test code to demonstrate the problem (attached).
>>
>> The check_shift_count() warning is only supposed to be printed for
>> number literals but because of the way inline functions are expanded it
>> still complains even though channel is a variable.
>
> Thanks for the test case; this definitely makes no sense.  I don't think
> Sparse will suddenly develop enough range analysis or reachability
> analysis to handle this case; I think the right answer is to avoid
> giving such warnings for shifts with a non-constant RHS.

Sparse can handle inline function expand and some constant
propagate. In this case, sparse seems doing the right thing.
Sparse actually sees the channel value being  4294967295 (-1).


>> static inline unsigned ni_stc_dma_channel_select_bitfield(unsigned channel)

This is the bug. See this channel is *unsigned*. When -1 pass into
channel, it become a really large number 4294967295.
The code does request C compiler to perform left shift 4294967295 bits.
Which did not make sense.

>> {
>>       if (channel < 4)
>>               return 1 << channel;
>>       return 0;
>> }
>>
>> static inline void filter(int channel)
>> {
>>       if (channel < 0)
>>               return;
>>       ni_stc_dma_channel_select_bitfield(channel);

See this channel is *signed*, with -1 convert to 4294967295.
This is a bug in the kernel source not sparse.

Chris
