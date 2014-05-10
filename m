From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] staging: rtl8192u: initialize array in C compliant way
Date: Sat, 10 May 2014 02:09:52 -0700
Message-ID: <CANeU7Qkpg3_mYEYqZpT2zy__6z0q8KDNB=gDH9oMY8UtQNu0+Q@mail.gmail.com>
References: <1399364528-3727-1-git-send-email-martink@posteo.de>
 <20140506084749.GT26890@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20140506084749.GT26890@mwanda>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: devel@driverdev.osuosl.org, Greg KH <gregkh@linuxfoundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux-Sparse <linux-sparse@vger.kernel.org>, burzalodowa@gmail.com, Martin Kepplinger <martink@posteo.de>
List-Id: linux-sparse@vger.kernel.org

On Tue, May 6, 2014 at 1:47 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>> diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
>> index 426f223..c96dbab 100644
>> --- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
>> +++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
>> @@ -241,7 +241,7 @@ static PTS_COMMON_INFO SearchAdmitTRStream(struct ieee80211_device *ieee,
>>  {
>>       //DIRECTION_VALUE       dir;
>>       u8      dir;
>> -     bool                            search_dir[4] = {0, 0, 0, 0};
>> +     bool                            search_dir[4] = {0};
>
> That's weird.  The original code is valid but it generates a sparse
> warning.

Sorry for the late reply. I see what is going on already. The bits_to_bytes()
function is buggy for bool type. Bool is the only type has bits less than 8.
It truncates the bool byte size to 0. As a result, the array layout function
convert_index() always set the expr->init_offset to 0 for bool type:

"e->init_offset = from * bits_to_bytes(e->ctype->bit_size);"

Chris
