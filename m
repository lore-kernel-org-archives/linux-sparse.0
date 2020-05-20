From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v1 01/28] misc: fix testcase typeof-safe
Date: Wed, 20 May 2020 16:34:53 +0100
Message-ID: <2de08a4e-ce53-8694-da00-c2c90334da65@ramsayjones.plus.com>
References: <20200519005728.84594-1-luc.vanoostenryck@gmail.com>
 <20200519005728.84594-2-luc.vanoostenryck@gmail.com>
 <422723ea-00aa-ee89-72aa-f4dddbd8da06@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout07.plus.net ([84.93.230.235]:34523 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgETPm2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 20 May 2020 11:42:28 -0400
In-Reply-To: <422723ea-00aa-ee89-72aa-f4dddbd8da06@ramsayjones.plus.com>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-sparse@vger.kernel.org



On 20/05/2020 01:33, Ramsay Jones wrote:
> On 19/05/2020 01:57, Luc Van Oostenryck wrote:
>> This testcase was marked as known-to-fail but it was
>> simply the expected error messages that were missing.
>>
>> So, slightly reorganize the test a little bit, add the
>> expected messages and remove the 'known-to-fail' tag.
>>
>> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
>> ---
>>  validation/typeof-safe.c | 26 ++++++++++++++++++++------
>>  1 file changed, 20 insertions(+), 6 deletions(-)
>>
>> diff --git a/validation/typeof-safe.c b/validation/typeof-safe.c
>> index 614863fba381..508bd39204c5 100644
>> --- a/validation/typeof-safe.c
>> +++ b/validation/typeof-safe.c
>> @@ -2,16 +2,24 @@
>>  
>>  static void test_safe(void)
>>  {
>> -	int __safe obj, *ptr;
>> -	typeof(obj) var = obj;
>> -	typeof(ptr) ptr2 = ptr;
>> +	int obj;
>> +	int __safe *ptr;
>> +
>> +	int __safe *ptr2 = ptr;
>> +	typeof(ptr) ptr3 = ptr;
>>  	typeof(*ptr) var2 = obj;
>> -	typeof(*ptr) *ptr3 = ptr;
>> -	typeof(obj) *ptr4 = ptr;
>> +	int __safe  var3 = obj;
>> +	int *ptr4 = &obj;
>> +	int *ptr4 = ptr;		// KO
> 
> ptr4 declared twice - and sparse didn't complain?

Heh, I had a slightly different example in the test case
for my '{0}' initializer patch (but involving different
types as well).

I had a quick look at this and tried to use 'git-bisect' to
isolate the change which broke this. However, I couldn't find
a version of sparse that worked correctly! :D (I went all the
way back to v0.4.2 before giving up - several tagged releases
didn't even compile without some fix-ups, including v0.4.2).

Just FYI, this was my test-case:

  $ cat -n test-dup-decl.c
       1	#ifdef WORKS_OK
       2	static int sobj;
       3	static int *sptr4 = &sobj;
       4	static int *sptr4 = 0;
       5	#endif
       6	
       7	static void func(void)
       8	{
       9		int obj, *ptr;
      10		int *ptr4 = &obj;
      11		int *ptr4 = ptr;
      12		int a;
      13		float a;
      14	}
  $ 

  $ gcc -c test-dup-decl.c
  test-dup-decl.c: In function ‘func’:
  test-dup-decl.c:11:7: error: redefinition of ‘ptr4’
    int *ptr4 = ptr;
         ^~~~
  test-dup-decl.c:10:7: note: previous definition of ‘ptr4’ was here
    int *ptr4 = &obj;
         ^~~~
  test-dup-decl.c:13:8: error: conflicting types for ‘a’
    float a;
          ^
  test-dup-decl.c:12:6: note: previous declaration of ‘a’ was here
    int a;
        ^
  $ 

  $ ./sparse test-dup-decl.c
  $ 

ATB,
Ramsay Jones
