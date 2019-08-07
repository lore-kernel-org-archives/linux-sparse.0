From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH net-next] net: can: Fix compiling warning
Date: Wed, 7 Aug 2019 13:50:42 +0300
Message-ID: <20190807105042.GK1974@kadam>
References: <20190802033643.84243-1-maowenan@huawei.com>
 <0050efdb-af9f-49b9-8d83-f574b3d46a2e@hartkopp.net>
 <20190806135231.GJ1974@kadam>
 <6e1c5aa0-8ed3-eec3-a34d-867ea8f54e9d@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6e1c5aa0-8ed3-eec3-a34d-867ea8f54e9d@hartkopp.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>, Patrick Bellasi <patrick.bellasi@arm.com>, linux-sparse@vger.kernel.org
Cc: Mao Wenan <maowenan@huawei.com>, davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
List-Id: linux-sparse@vger.kernel.org

On Tue, Aug 06, 2019 at 06:41:44PM +0200, Oliver Hartkopp wrote:
> I compiled the code (the original version), but I do not get that "Should it
> be static?" warning:
> 
> user@box:~/net-next$ make C=1
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/atomic/check-atomics.sh
>   DESCEND  objtool
>   CHK     include/generated/compile.h
>   CHECK   net/can/af_can.c
> ./include/linux/sched.h:609:43: error: bad integer constant expression
> ./include/linux/sched.h:609:73: error: invalid named zero-width bitfield
> `value'
> ./include/linux/sched.h:610:43: error: bad integer constant expression
> ./include/linux/sched.h:610:67: error: invalid named zero-width bitfield
> `bucket_id'
>   CC [M]  net/can/af_can.o

The sched.h errors suppress Sparse warnings so it's broken/useless now.
The code looks like this:

include/linux/sched.h
   613  struct uclamp_se {
   614          unsigned int value              : bits_per(SCHED_CAPACITY_SCALE);
   615          unsigned int bucket_id          : bits_per(UCLAMP_BUCKETS);
   616          unsigned int active             : 1;
   617          unsigned int user_defined       : 1;
   618  };

bits_per() is zero and Sparse doesn't like zero sized bitfields.

regards,
dan carpenter
